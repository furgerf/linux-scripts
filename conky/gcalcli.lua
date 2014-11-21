#!/usr/bin/lua

local format = "%Y-%m-%dT%H:%M"
local fh = io.popen("gcalcli --cal Privat#red --cal Arbeit#magenta --cal HSLU#yellow --cal Running#cyan --cal Squash#green --military --conky --color_date white agenda " .. os.date(format, os.time()) .. " " .. os.date(format, os.time() + 259200))
local data = fh:read("*l")
local result = ""

while data ~= nil do
    if data:len() > 20 then
        data = data .. "\n"
    end

    local date = data:sub(1, 22)
    local time
    local title
    local index = data:find("}", 22)

    if index ~= nil then
        time = data:sub(25, index + 7):gsub("  ", "")
        title = data:sub(index + 10)
    end

    if time == nil then
        result = result .. date
    else
        result = result .. date .. "${goto 66}" .. time .. "${goto 100}" .. title
    end

    data = fh:read("*l")
end

print(result:sub(1, #result - 1))

