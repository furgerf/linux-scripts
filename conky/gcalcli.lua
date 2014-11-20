#!/usr/bin/lua

local format = "%Y-%m-%dT%H:%M"
local fh = io.popen("gcalcli --cal Privat#red --cal Arbeit#magenta --cal HSLU#yellow --cal Running#cyan --cal Squash#green --military --conky --color_date white agenda " .. os.date(format, os.time()) .. " " .. os.date(format, os.time() + 259200))
local data = fh:read("*l")
local result = ""

while data ~= nil do
    if data:len() > 20 then
        data = data .. "\n"
    end
    result = result .. data
    data = fh:read("*l")
end

print("${font DejaVuSansMono:size=8}" .. result:sub(1, #result - 1) .. "$font")

