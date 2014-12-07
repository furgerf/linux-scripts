#!/usr/bin/lua

local format = "%Y-%m-%dT%H:%M"
local fh = io.popen("gcalcli --cal Privat#red --cal Arbeit#magenta --cal HSLU#yellow --cal Running#cyan --cal Squash#green --military --conky --color_date white agenda " .. os.date(format, os.time()) .. " " .. os.date(format, os.time() + 7 * 86400))

local datapath = "gcalcli_data"

local data = fh:read("*l")
while data ~= nil and data:len() < 20 do
    data = fh:read("*l")
end

local result = ""
local lines = 10

while data ~= nil do
    lines = lines - 1
    
    local date = ""
    if data:sub(1, 1) ~= "$" then
        if lines < 0 then
            break
        end
        date = "${color white}" .. data:sub(1, 10)
    end

    local colorstart = data:find("{", 3) - 1
    local colorend = data:find("}", colorstart)
    local color = data:sub(colorstart, colorend)
    
    local timestart = data:find(":") - 2
    local time = data:sub(timestart, timestart + 5)

    local title = data:sub(timestart + 7)
    
    result = result .. "\n" .. date .. "${goto 68}" .. color .. time .. "${goto 100}" .. title

    data = fh:read("*l")
    while data ~= nil and data:len() < 20 do
        data = fh:read("*l")
    end
end
fh:close()

-- if no new data was found (offline?), print last data
if #result == 0 then
    fh = io.open(datapath, "r")
    if fh ~= nil then
        print(fh:read("*a"))
        fh:close()
    end
else
    print(result:sub(2))
    fh = io.open(datapath, "w")
    fh:write("⚫ " .. result:sub(2):gsub("\n", "\n${color white}⚫ "):gsub("68", "80"):gsub("100", "112"))
    fh:close()
end

