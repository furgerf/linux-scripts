#!/bin/lua

local startdate
local enddate

if arg[1] == "today" then
    startdate = os.date("*t")
    startdate.hour = 0
    startdate.min = 0
    startdate.sec = 0
    startdate = os.time(startdate)
    enddate = os.date("*t")
    enddate.hour = 23
    enddate.min = 59
    enddate.sec = 59
    enddate = os.time(enddate)
elseif arg[1] == "tomorrow" then
    startdate = os.date("*t")
    startdate.day = startdate.day + 1
    startdate.hour = 0
    startdate.min = 0
    startdate.sec = 0
    startdate = os.time(startdate)
    enddate = os.date("*t")
    enddate.day = enddate.day + 1
    enddate.hour = 23
    enddate.min = 59
    enddate.sec = 59
    enddate = os.time(enddate)
elseif arg[1] == "nextweek" then
    startdate = os.date("*t")
    startdate.hour = 0
    startdate.min = 0
    startdate.sec = 0
    startdate = os.time(startdate)
    enddate = os.date("*t")
    enddate.day = enddate.day + 7
    enddate.hour = 23
    enddate.min = 59
    enddate.sec = 59
    enddate = os.time(enddate)
elseif arg[6] ~= nil then
    startdate = os.time{ year=arg[1], month=arg[2], day=arg[3], hour=0, minute=0, second=0 }
    enddate = os.time{ year=arg[4], month=arg[5], day=arg[6], hour=23, minute=59, second=59 }
else
    print("Usage: ./timetable.lua start:year start:month start:day end:year end:month end:day")
    return
end


os.execute("killall wget &> /dev/null")
os.execute("./timetable_helper.sh")

local skip = true

function string.starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
end

function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end


local entries = {}
local index = 0
local cursor = 0
local startSeconds = -1

for line in io.lines("timetable_data") do
    if string.starts(line, "ourEventId:") then
        skip = false
    end

    if skip == false then
        if cursor == 0 then
            if string.starts(line, "moduleDesc:") then
                entries[index] = {}
                entries[index][cursor] = line:sub(14, #line - 3)
                cursor = cursor + 1
            end
        elseif cursor == 1 then
            if string.starts(line, "room:") then
                entries[index][cursor] = line:sub(8, #line - 3)
                cursor = cursor + 1
            end
        elseif cursor == 2 then
            if string.starts(line, "start:") then
                local date = line:sub(17, #line - 3):split(", ")
                local datetime = os.time{ year=date[1], month=date[2]+1, day=date[3], hour=date[4], minute=date[5] }
                
                if datetime > enddate or datetime < startdate then
                    entries[index] = nil
                    cursor = 0
                else
                    entries[index][cursor] = os.date("%m/%d/%Y", datetime)
                    entries[index][cursor + 1] = os.date("%H:%M", datetime)
                    startSeconds = os.date(datetime)
                    cursor = cursor + 2
                end
            end
        elseif cursor == 4 then
            if string.starts(line, "end:") then
                local date = line:sub(15, #line - 3):split(", ")
                local datetime = os.time{ year=date[1], month=date[2]+1, day=date[3], hour=date[4], minute=date[5] }
                entries[index][cursor] = (os.date(datetime) - startSeconds) / 60
                cursor = cursor + 1
            end
        elseif cursor == 5 then
            index = index + 1
            cursor = 0
        end
    end
end

print("Press <Enter> to see the entries")
io.read("*l")
local count = 0
for i = 0, index do
    if entries[i] ~= nil then
        --print("google calendar add --cal=HSLU \"" .. entries[i][0] .. " (" .. entries[i][1] .. ") on " .. entries[i][2] .. " from " .. entries[i][3] .. " till " .. entries[i][4] .. "\"")
        print("gcalcli --calendar HSLU --title \"" .. entries[i][0] .. "\" --where \"" .. entries[i][1] .. "\" --when \"" .. entries[i][2] .. " " .. entries[i][3] .. "\" --duration \"" .. entries[i][4] .. "\" --noprompt add")
        count = count + 1
    end
end

--print("\nIn order to work with my calendar, I\'ll add one hour to every event. Do you want to add these " .. count .. " entries? (y/n)")
print("\nDo you want to add these " .. count .. " entries? (y/n)")

repeat
    execute = io.read("*l")
until execute ~= ""
print("")

if execute == "y" or execute == "Y" then
    print("Working...")
    for i = 0, index do
        if entries[i] ~= nil then
            --os.execute("google calendar add --cal=HSLU \"" .. entries[i][0] .. " (" .. entries[i][1] .. ") on " .. entries[i][2] .. " from " .. entries[i][3] .. " till " .. entries[i][4] .. "\"")
            os.execute("gcalcli --calendar HSLU --title \"" .. entries[i][0] .. "\" --where \"" .. entries[i][1] .. "\" --when \"" .. entries[i][2] .. " " .. entries[i][3] .. "\" --duration \"" .. entries[i][4] .. "\" --noprompt add")
        end
    end
    print("Done!")
else
    print("Aborting...")
end

os.execute("rm timetable_data")

