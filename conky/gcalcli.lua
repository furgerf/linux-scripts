#!/usr/bin/lua

local format = "%Y-%m-%dT%H:%M"
local fh = io.popen("gcalcli --cal Privat#red --cal Arbeit#magenta --cal HSLU#yellow --cal Running#cyan --cal Squash#green --military --conky --color_date white agenda " .. os.date(format, os.time()) .. " " .. os.date(format, os.time() + 259200))

--print(fh:read("*a"))

local data = fh:read("*l")
local result = ""

while data ~= nil do
    if data:len() > 20 then
        data = data .. "\n"
    end
    
    local date = data:sub(1, data:find("}"))
    local time
    local title
    local index = data:find("}", 22)

    if index ~= nil then
        time = data:sub(25, index + 7):gsub("  ", "")
        if time:sub(1, 1) == "}" then
            time = time:sub(2)
        end
        title = data:sub(index + 10)
        result = result .. date .. "${goto 66}" .. time .. "${goto 100}" .. title
    else
        result = result .. date
    end

    data = fh:read("*l")
end

print(result:sub(1, #result - 1))

