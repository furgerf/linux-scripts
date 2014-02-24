#!/usr/bin/lua

function string:split( inSplitPattern, outResults )
   if not outResults then
      outResults = { }
   end
   local theStart = 1
   local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
   while theSplitStart do
      table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
      theStart = theSplitEnd + 1
      theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
   end
   table.insert( outResults, string.sub( self, theStart ) )
   return outResults
end

local data_path = string.sub(arg[0], 0, -5) .. "_data"

local dateformat = "(%a+) (%d+) (%d+):(%d+)" 
local months = { Jan = 1, Feb = 2, Mar = 3, Apr = 4, May = 5, Jun = 6, Jul = 7, Aug = 8, Sep = 9, Oct = 10, Nov = 11, Dec = 12 }

local now = os.time()
local now_string = os.date("%Y-%m-%d", now)

local apps = {}

local count = 0

-- iterate over calendars (arguments)
for i,v in ipairs(arg) do
    -- read calendar data
    local handle = 0
    if (count > 2) then
        local oldest_key = 0
        for t,d in pairs(apps) do
            if (oldest_key < t) then
                oldest_key = t
            end
        end

        local max_date = os.date("%Y-%m-%d", oldest_key)
        handle = io.popen("google calendar list --cal " .. v .. " --date " .. now_string .. "," .. max_date .. " --delimiter ';' | grep ';'")
        --print("For calendar " .. v .. " max date " .. max_date)
    else
        handle = io.popen("google calendar list --cal " .. v .. " --delimiter ';' | grep ';'")
        --print("For calendar " .. v .. " no max date")
    end

    local data = handle:read("*a")
    handle:close()
    local split = data:split("\n")

    -- iterate over appointments in calendar
    for j = 1, #split-1 do
        -- parse time of appointment
        local line = split[j]:split(";")
        local month,day,hour,minute = line[2]:match(dateformat)
        month = months[month]
        local time = os.time({ year = os.date("%Y"), month = month, day = day, hour = hour, minute = minute })

        -- appointment is only interesting if it's not in the past
        if (time >= now) then
            -- if we have less than 3 appointments, add it
            if (count < 3) then
                apps[time] = { v, line[1], line[2] }
                count = count + 1
            else
                -- else, check whether there is a later appointment to kick out
                local oldest_key = 0
    
                for t,d in pairs(apps) do
                    if (oldest_key < t) then
                        oldest_key = t
                    end
                end
    
                if (time < oldest_key) then
                    -- later appointment found, replace it
                    apps[oldest_key] = nil
                    apps[time] = { v, line[1], line[2] }
                else
                    -- we will only get older events, break loop
                    break
                end
            end
        end
    end
end

-- find first and last appointment
local lowest = nil
local highest = 0
for k,v in pairs(apps) do
    if (highest < k) then
        highest = k
    end

    --print(apps[k][1] .. apps[k][2] .. apps[k][3])

    if (lowest == nil or lowest > k) then
        lowest = k
    end
end

-- if no new data was found (offline?), print last data
if (lowest == nil) then
    local oldhandle = io.open(data_path, "r")
    if (oldhandle ~= nil) then
        local d = oldhandle:read("*a")
        --print("old data")
        print(d:sub(1, d:len() - 1))
        io.close(oldhandle)
    end
    return
end

-- first appointment
local finaldata = apps[lowest][2] .. "${goto 130}" .. apps[lowest][1] .. "${alignr}" .. apps[lowest][3]
-- find and add middle appointment
for k,v in pairs(apps) do
    if (k ~= highest and k ~= lowest) then
        finaldata = finaldata .. "\n" .. apps[k][2] .. "${goto 130}" .. apps[k][1] .. "${alignr}" .. apps[k][3]
        break
    end
end

-- add last appointment
finaldata = finaldata .. "\n" .. apps[highest][2] .. "${goto 130}" .. apps[highest][1] .. "${alignr}" .. apps[highest][3]

print(finaldata)

local lasthandle = io.open(data_path, "w")
lasthandle:write("* " .. string.gsub(finaldata, "\n", "\n* ") .. "\n")
lasthandle:close()

