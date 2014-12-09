local string = string
local tostring = tostring
local os = os
local capi = {
    mouse = mouse,
    screen = screen
}
local awful = require("awful")
local naughty = require("naughty")
local io = require("io")
local table = require("table")

module("calendar2")

local calendar = {}
local current_day_format = "<u>%s</u>"
local widgetid
local todayNaughty

function displayMonth(month,year,weekStart)
        local t,wkSt=os.time{year=year, month=month+1, day=0},weekStart or 1
        local d=os.date("*t",t)
        local mthDays,stDay=d.day,(d.wday-d.day-wkSt+1)%7

        --print(mthDays .."\n" .. stDay)
        local lines = "    " .. " "

        for x=0,6 do
                lines = lines .. os.date("%a ",os.time{year=2006,month=1,day=x+wkSt})
        end

        lines = lines .. "\n" .. os.date(" %V",os.time{year=year,month=month,day=1}) .. " "

        local writeLine = 1
        while writeLine < (stDay + 1) do
                lines = lines .. "    "
                writeLine = writeLine + 1
        end

        for d=1,mthDays do
                local x = d
                local t = os.time{year=year,month=month,day=d}
                if writeLine == 8 then
                        writeLine = 1
                        lines = lines .. "\n" .. os.date(" %V",t) .. " "
                end
                if os.date("%Y-%m-%d") == os.date("%Y-%m-%d", t) then
                        x = string.format(current_day_format, d)
                end
                if (#(tostring(d)) == 1) then
                        x = " " .. x
                end
                lines = lines .. "  " .. x
                writeLine = writeLine + 1
        end

        local header = "<span color='#4d79ff'>" .. os.date("%B %Y\n",os.time{year=year,month=month,day=1}) .. "</span>"

        return header .. lines
        
--        return header .. lines .. "\n\n" .. "<span color='#4d79ff'>Privat</span>\n" .. readCalendar("Privat") .. "\n\n<span color='#4d79ff'>Arbeit</span>\n" .. readCalendar("Arbeit") .. "\n\n<span color='#4d79ff'>HSLU</span>\n" .. readCalendar("HSLU") .. "\n\n<span color='#4d79ff'>Squash</span>\n" .. readCalendar("Squash")
        
end

function readCalendar(cal)
    local handle = io.popen("google calendar list --cal " .. cal .. " | grep ,")
    local data = handle:read("*a")
    handle:close()

    local split = data:split("\n")

    local result = ""
    local temp = ""
    local longest = 0
    local count = 6
    if (#split < 6) then
        count = #split
    end
    count = count - 1

    for i = 1, count do
        temp = string.sub(split[i], 0, split[i]:find(","))
        if (string.len(temp) > longest) then
            longest = string.len(temp)
        end
    end

    for i = 1, count do
        temp = string.sub(split[i], 0, split[i]:find(",") - 1)

        while (string.len(temp) < longest) do
            temp = temp .. " "
        end

        result = result .. temp .. string.sub(split[i], split[i]:find(",") + 1, string.len(split[i])) .. "\n"
    end

    return string.sub(result, 0, string.len(result) - 1)
end

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

function switchNaughtyMonth(switchMonths)
        if (#calendar < 3) then return end
        local swMonths = switchMonths or 1
        calendar[1] = calendar[1] + swMonths
        naughty.notify({
            text = string.format('<span font_desc="%s">%s</span>', "monospace", displayMonth(calendar[1], calendar[2], 2)),
            timeout = 0,
            hover_timeout = 0.5,
            screen = capi.mouse.screen,
            replaces_id = widgetid
        })
end

function switchNaughtyGoToToday()
        if (#calendar < 3) then return end
        local swMonths = switchMonths or 1
        calendar[1] = os.date("*t").month
        calendar[2] = os.date("*t").year
       switchNaughtyMonth(0)
end

function addCalendarToWidget(mywidget, custom_current_day_format)
  if custom_current_day_format then current_day_format = custom_current_day_format end

  mywidget:connect_signal('mouse::enter', function ()
        local month, year = os.date('%m'), os.date('%Y')
        calendar = { month, year,
    naughty.notify({
            text = string.format('<span font_desc="%s">%s</span>', "monospace", displayMonth(month, year, 2)),
            timeout = 0,
            hover_timeout = 0.5,
            screen = capi.mouse.screen
    })
  }
  widgetid = calendar[3].id
  end)

--[[
  mywidget:connect_signal('mouse::enter', function ()
        local fh = io.popen("google calendar today --cal=Privat | sed -n '3,20p'")
        local todayData = ""
        local tmp = fh:read("*a")
        if #tmp > 0 then
            todayData = todayData .. "\tPrivat:\n" .. tmp
        end
        fh:close()
        fh = io.popen("google calendar today --cal=Arbeit | sed -n '3,20p'")
        tmp = fh:read("*a")
        if #tmp > 0 then
            todayData = todayData .. "\tArbeit:\n" .. tmp
        end
        fh:close()
        fh = io.popen("google calendar today --cal=HSLU | sed -n '3,20p'")
        tmp = fh:read("*a")
        if #tmp > 0 then
            todayData = todayData .. "\tHSLU:\n" .. tmp
        end
         fh:close()
        fh = io.popen("google calendar today --cal=Running | sed -n '3,20p'")
        tmp = fh:read("*a")
        if #tmp > 0 then
            todayData = todayData .. "\tRunning:\n" .. tmp
        end
        fh:close()
        fh = io.popen("google calendar today --cal=Squash | sed -n '3,20p'")
        tmp = fh:read("*a")
        if #tmp > 0 then
            todayData = todayData .. "\tSquash:\n" .. tmp
        end
        fh:close()

        todayNaughty = naughty.notify({
        text = "Today\n\n" .. todayData:sub(1, #todayData - 1),
        timeout = 0,
        hover_timeout = 0.5,
        screen = capi.mouse.screen
    })
end)
    --]]

  mywidget:connect_signal('mouse::leave', function () naughty.destroy(calendar[3]) naughty.destroy(todayNaughty) end)

  mywidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function()
        switchNaughtyMonth(1)
    end),
    awful.button({ }, 2, switchNaughtyGoToToday),
    awful.button({ }, 3, function()
        switchNaughtyMonth(-1)
    end),
    awful.button({ }, 4, function()
        switchNaughtyMonth(1)
    end),
    awful.button({ }, 5, function()
        switchNaughtyMonth(-1)
    end),
    awful.button({ 'Shift' }, 1, function()
        switchNaughtyMonth(12)
    end),
    awful.button({ 'Shift' }, 3, function()
        switchNaughtyMonth(-12)
    end),
    awful.button({ 'Shift' }, 4, function()
        switchNaughtyMonth(12)
    end),
    awful.button({ 'Shift' }, 5, function()
        switchNaughtyMonth(-12)
    end)
  ))
end
