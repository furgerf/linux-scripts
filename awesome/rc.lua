local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
naughty = require("naughty")
local menubar = require("menubar")
local shifty = require("shifty")
--local bashets = require("bashets")

awful.rules = require("awful.rules")
vicious = require("vicious")
calendar = require("calendar2")

-- {{{ Error handling
-- Errors at startup
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end
-- Runtime errors
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}



-- {{{ Variables
beautiful.init("/usr/share/awesome/themes/archdove/theme.lua")

terminal = "xfce4-terminal"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -x " .. editor

modkey = "Mod4"
altkey = "Mod1"

local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}



-- {{{ Random Wallpapers
-- Apply a random wallpaper if not specified in AWESOME_BG
if os.getenv("AWESOME_BG") then
  gears.wallpaper.maximized(os.getenv("AWESOME_BG"))
else
  -- Get the list of files from a directory. Must be all images or folders and non-empty. 
  function scanDir(directory)
    local i, fileList, popen = 0, {}, io.popen
    for filename in popen([[find "]] ..directory.. [[" -type f]]):lines() do
      i = i + 1
      fileList[i] = filename
    end
    return fileList
  end
  wallpaperList = scanDir("/usr/share/awesome/themes/archdove/wallpapers")

  local wp = wallpaperList[math.random(1, #wallpaperList)]
  for s = 1, screen.count() do
    gears.wallpaper.maximized(wp, s, true)
  end
  -- Apply a random wallpaper every changeTime seconds.
  changeTime = 3600
  wallpaperTimer = timer { timeout = changeTime }
  wallpaperTimer:connect_signal("timeout", function()
    local wp = wallpaperList[math.random(1, #wallpaperList)]
    for s = 1, screen.count() do
        gears.wallpaper.maximized(wp, s, true)
    end

    -- stop the timer (we don't need multiple instances running at the same time)
    wallpaperTimer:stop()

    --restart the timer
    wallpaperTimer.timeout = changeTime
    wallpaperTimer:start()
  end)

  -- initial start when rc.lua is first run
  wallpaperTimer:start()
end
-- }}}



-- {{{ Tags
shifty.config.tags = {
    ["~"] = {
        layout      = awful.layout.suit.fair,
        position    = 1,
        init        = true,
        --screen      = 2,
    },
    ["foo"] = {
        layout      = awful.layout.suit.tile.bottom,
        position    = 7,
        --init        = true,
        mwfact      = 0.7,
        screen      = 1,
    },
    ["2:web"] = {
        layout      = awful.layout.suit.floating,
        position    = 2,
        nopopup     = true,
        --leave_kills = true,
        --spawn       = "if [[ $(pidof firefox) -gt 0 ]] ; then firefox & ; fi",
        spawn       = "ps aux | grep [f]irefox ; if [[ $? -eq 0 ]] ; then firefox ; fi",
        screen      = screen.count(),
        persist     = false,
     },
    ["3:doc"] = {
        layout      = awful.layout.suit.fair,
        position    = 3,
        nopopup     = true,
        --leave_kills = true,
        persist     = false,
        screen      = screen.count(),
    },
    ["4:code"] = {
        layout      = awful.layout.suit.max.fullscreen,
        position    = 4,
        nopopup     = true,
        --leave_kills = true,
        screen      = screen.count(),
        persist     = false,
    },
    ["5:media"] = {
        layout      = awful.layout.suit.floating,
        position    = 5,
        --leave_kills = true,
        nopopup     = true,
        spawn       = terminal .. " --working-directory /data/video",
        persist     = false,
    },
    ["6:d/l"] = {
        layout      = awful.layout.suit.tile.bottom,
        position    = 6,
        nopopup     = true,
        --leave_kills = true,
        screen      = 1,
        persist     = false,
    },
    ["bar"] = {
        layout      = awful.layout.suit.fair,
        position    = 8,
        --init        = true,
        screen      = 1,
    },
    ["gimp"] = {
        layout      = awful.layout.suit.floating,
        --leave_kills = true,
        screen = screen.count(),
        persist     = false,
    },
}
shifty.config.apps = {
    {
        match = {
            class = { "Firefox" },
        },
        tag = "2:web",
        --maximize_vertical = true,
        --maximize_horizontal = true,
        screen = math.min(screen.count(), 2),
        dockable = true,
    },
    {
        match = {
            class = { "Wine" },
        },
        float = true,
    },
    {
        match = {
            class = {
                "Okular",
                "libreoffice-writer",
                "libreoffice*",
            },
        },
        tag = "3:doc",
        screen = math.min(screen.count(), 2),
    },
    {
        match = {
            class = { "bashrun2-run-dialog",
                    "bashrun", "XTerm" },
        },
        float = true,
    },
    {
        match = {
            class = { "Eclipse", "Brackets" },
        },
        tag = "4:code",
        screen = math.min(screen.count(), 2),
        --run = function () awful.util.spawn("./$HOME/git/linux-scripts/logcat"),
    },
    {
        match = {
            class = {
                "Corebird",
            }
        },
        tag = "2:web",
    },
    {
        match = {
            class = {
                "Vlc",
                "Clementine",
                "Gsopcast",
            },
        },
        tag = "5:media",
    },
    {
        match = {
            class = {
                "Qbittorrent",
                "Vuze",
            },
            name = {
                "JDownloader",
            },

        },
        tag = "6:d/l",
        screen = 1,
    },
    {
        match = {
            "Gimp",
        },
        tag = "gimp",
        screen = math.min(screen.count(), 2),
        slave = true,
    },
    {
        match = {
            "gimp%-image%-window",
        },
        slave = true,
        screen = math.min(screen.count(), 2),
    },
    {
        match = {
            ""
        },
        buttons = awful.util.table.join(
            awful.button({}, 1, function (c) client.focus = c; c:raise() end),
            awful.button({ modkey }, 1, function(c)
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
            end),
            awful.button({ modkey }, 3, awful.mouse.client.resize)
            ),
    }
}
-- }}}



-- {{{ Menu
myconfigmenu = {
    { "xinit", editor_cmd .. " " .. os.getenv("HOME") .. "/.xinitrc" },
    { "bash", editor_cmd .. " " .. os.getenv("HOME") .. "/.bashrc" },
    { "awesome", editor_cmd .. " " .. awesome.conffile },
    { "conky", editor_cmd .. " " .. os.getenv("HOME") .. "/git/linux-scripts/conky/.conkyrc" },
    { "vim", editor_cmd .. " " .. os.getenv("HOME") .. "/.vimrc" },
}
myplacemenu = {
    { "/data", "thunar /data" },
    { "-> audio", "thunar /data/audio" },
    { "-> torrents", "thunar /data/torrents" },
    { "-> video", "thunar /data/video" },
    { "Dropbox", "thunar /data/Dropbox" }
}
myplacestermmenu = {
    { "/data", terminal .. " --working-directory /data" },
    { "-> audio", terminal .. " --working-directory /data/audio" },
    { "-> torrents", terminal .. " --working-directory /data/torrents" },
    { "-> video", terminal .. " --working-directory /data/video" },
    { "Dropbox", terminal .. " --working-directory /data/Dropbox" }
}
myawesomemenu = {
    { "manual", terminal .. " -x man awesome" },
    { "restart", awesome.restart },
    { "quit", awesome.quit }
}
mymainmenu = awful.menu({
  items = {
    { "places terminal", myplacestermmenu, beautiful.terminal_icon },
    { "places explorer", myplacemenu, beautiful.explorer_icon },
    { "config", myconfigmenu, beautiful.config_icon },
    { "awesome", myawesomemenu, beautiful.awesome_icon },
  }
})
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
-- Menubar configuration
menubar.utils.terminal = terminal
-- }}}



-- {{{ Wibox
-- Create a volume widget
volwrapper = wibox.widget.background()
volwidget = wibox.widget.textbox()
volicon = wibox.widget.imagebox()
vicious.register(volwidget, vicious.widgets.volume,
function(widget, args)
  local label = { ["♫"] = "O", ["♩"] = "M" }
  if label[args[2]] == "M" then
    volicon:set_image(beautiful.sound_mute)
    volicon:set_resize(false)
  elseif args[1]>0 and args[1]<=25 then
    volicon:set_image(beautiful.sound_1_25)
    volicon:set_resize(false)
  elseif args[1]>25 and args[1]<=50 then
    volicon:set_image(beautiful.sound_26_50)
    volicon:set_resize(false)
  elseif args[1]>50 and args[1]<=75 then
    volicon:set_image(beautiful.sound_51_75)
    volicon:set_resize(false)
  elseif args[1]>75 and args[1]<=100 then
    volicon:set_image(beautiful.sound_76_100)
    volicon:set_resize(false)
  else
    volicon:set_image(beautiful.sound_mute)
    volicon:set_resize(false)
  end
  return " ".. args[1] .. " "
end, 0.2, "Master")
volwrapper:set_widget(volwidget)

-- Create a battery widget
battwidget = wibox.widget.textbox()
batticon = wibox.widget.imagebox()
vicious.register(battwidget, vicious.widgets.bat,
function(widget, args)
  fh = assert(io.popen("acpi | cut -d, -f 1,1 | cut -d: -f2,2 | cut -b 2-", "r"))
  local direction = fh:read("*l")
  fh.close() 
  fh = assert(io.popen("acpi | cut -d, -f 3,3 - | cut -b 2-9", "r"))
  local charging_duration = fh:read("*l")
  fh.close()
  local direction_sign = args[1]
  if direction == "Discharging" then
    direction_sign = "-"
    chargedesc = " (" .. charging_duration .. " rem)"
  elseif direction == "Charging" and charging_duration ~= "charging" then
    directon_sign = "+"
    chargedesc = " (" .. charging_duration .. " rem)"
  elseif direction == "Unknown" or (direction == "Charging" and charging_duration == "charging") then
    direction_sign = ""
    chargedesc = ""
  elseif direction == "Full" then
    chargedesc = direction_sign
    direction_sign = ""
  else
    chargedesc = "UNKNOWN CHARGING DIRECTION: \"" .. direction .. "\""
  end

  local batterypercentage = args[2] .. direction_sign .. "%" .. chargedesc
  if args[2]<=5 then
    batticon:set_image(beautiful.battery1)
  elseif args[2]>5 and args[2]<=10 then
    batticon:set_image(beautiful.battery2)
  elseif args[2]>10 and args[2]<=20 then
    batticon:set_image(beautiful.battery3)
  elseif args[2]>20 and args[2]<=30 then
    batticon:set_image(beautiful.battery4)
  elseif args[2]>30 and args[2]<=40 then
    batticon:set_image(beautiful.battery5)
  elseif args[2]>40 and args[2]<=50 then
    batticon:set_image(beautiful.battery6)
  elseif args[2]>50 and args[2]<=60 then
    batticon:set_image(beautiful.battery7)
  elseif args[2]>60 and args[2]<=70 then
    batticon:set_image(beautiful.battery8)
  elseif args[2]>70 and args[2]<=80 then
    batticon:set_image(beautiful.battery9)
  elseif args[2]>80 and args[2]<=90 then
    batticon:set_image(beautiful.battery10)
  else
    batticon:set_image(beautiful.battery11)
  end
  batticon:set_resize(false)
  return batterypercentage
end, 30, "BAT0")
battwrapper = wibox.widget.background()
battwrapper:set_widget(battwidget)

-- Create a wifi widget
wifiwidget = wibox.widget.textbox()
wifiicon = wibox.widget.imagebox()
vicious.register(wifiwidget, vicious.widgets.wifi,
	function(widget,args)
		signal = args['{link}']
		name = "" .. args['{ssid}']
		if signal > 0 and signal <=20 then
			wifiicon:set_image(beautiful.wifi1)
		elseif signal > 20 and signal <=40 then
			wifiicon:set_image(beautiful.wifi2)
		elseif signal > 40 and signal <=60 then
			wifiicon:set_image(beautiful.wifi3)
		elseif signal > 60 and signal <=80 then
			wifiicon:set_image(beautiful.wifi4)
		elseif signal > 80 and signal <=100 then
			wifiicon:set_image(beautiful.wifi5)
		else
			wifiicon:set_image(beautiful.wifinone)
		end
		wifiicon:set_resize(false)
		return name
	end,
3, "wlp3s0")
wifiwrapper = wibox.widget.background()
wifiwrapper:set_widget(wifiwidget)

-- Arrow Icons
arr9 = wibox.widget.textbox()
arr9:set_text(" ~ ")

-- Create a textclock widget
mytextclock = awful.widget.textclock("%A, %B %e, <span color='#4d79ff'>%H:%M</span>", 60)
calendar2.addCalendarToWidget(mytextclock, "<span color='#4d79ff'>%s</span>")
tclockwrapper = wibox.widget.background()
tclockwrapper:set_widget(mytextclock)

-- Pacman Update widget
pacuwrapper = wibox.widget.background()
pacuwidget = wibox.widget.textbox()
pacuwrapper:set_widget(pacuwidget)
pacutimer = timer({ timeout = 120 })
function update_pacuwidget ()
        local handle = io.popen("ping -c 1 8.8.8.8 &> /dev/null ; echo $?")
        local inet = handle:read("*a")
        handle:close()
        if inet:sub(1, #inet - 1) ~= "0" then
            naughty.notify({ text = "Package synchronization aborted: No Internet connection" })

            pacutimer.timeout = 1800
            pacutimer:again()
            
            return
        end
       
        -- update can proceed, only update bi-hourly from now on
        pacutimer.timeout = 7200
        pacutimer:again()
        
        -- sync pacman
        os.execute("sudo " .. os.getenv("HOME") .. "/git/linux-scripts/awesome/refresh_database")

        -- get new packages
        handle = io.popen("yaourt -Qu | wc -l")
        local count = handle:read("*a")
        handle:close()
        local count = count:sub(1, #count - 1)


        if tonumber(count) == 0 then
            pacuwidget:set_text("")
        else
            local newText = count .. " updates ~ "
            if pacuwidgettext ~= newText then
                pacuwidgettext = newText
                pacuwidget:set_text(count .. " updates ~ ")
                naughty.notify({ text = "Package database synchronized. New updates available: " .. count })
            end
        end
    end
local pacuwidgettext = ""
pacutimer:connect_signal( "timeout", update_pacuwidget)
pacutimer:start()

local pacu_naughty = nil
function remove_pacu_naughty()
    if pacu_naughty ~= nil then
        naughty.destroy(pacu_naughty)
        pacu_naughty = nil
    end
end
pacuwrapper:connect_signal("button::press", function() 
    awful.util.spawn(terminal .. " --geometry=64x20+1148+17 -x yaourt -Sau") 
    pacuwidget:set_text("")
    remove_pacu_naughty()
end)

pacuwrapper:connect_signal("mouse::enter", function()
        local handle = io.popen("yaourt -Qu")
        local packages = handle:read("*a")
        handle:close()
        remove_pacu_naughty()

        pacu_naughty = naughty.notify({ text = packages:sub(1, #packages - 1), timeout = 0 })
    end)
pacuwrapper:connect_signal("mouse::leave", remove_pacu_naughty)
--bashets.set_script_path(os.getenv("HOME") .. "/git/linux-scripts/awesome/")
--bashets.register("org.freedesktop.Hal.Manager", { dbus = true, busname = "system", widget = pacuwidget, format = "$3" })
--bashets.register("pac_trigger.sh", { callback = update_pacuwidget })
--bashets.start()
--]]


-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t)
                      awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t)
                      awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1,
                     function (c)
                       if c == client.focus then
                         c.minimized = true
                       else
                         c.minimized = false
                         if not c:isvisible() then
                           awful.tag.viewonly(c:tags()[1])
                         end
                         client.focus = c
                         c:raise()
                       end
                     end),
                     awful.button({ }, 3,
                     function ()
                       if instance then
                         instance:hide()
                         instance = nil
                       else
                         instance = awful.menu.clients({ width=250 })
                       end
                     end),
                     awful.button({ }, 4,
                     function ()
                       awful.client.focus.byidx(1)
                       if client.focus then client.focus:raise() end
                     end),
                     awful.button({ }, 5,
                     function ()
                       awful.client.focus.byidx(-1)
                       if client.focus then client.focus:raise() end
                     end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1,
                           function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3,
                           function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4,
                           function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5,
                           function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s,
      awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s,
      awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "16" })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    --left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(arr9)
    right_layout:add(pacuwrapper)
    --right_layout:add(cpuicon)
    --right_layout:add(cpuwrapper)
    --right_layout:add(arr9)
    right_layout:add(volicon)
    right_layout:add(volwrapper)
    right_layout:add(arr9)
    right_layout:add(batticon)
    right_layout:add(battwrapper)
    right_layout:add(arr9)
    right_layout:add(wifiicon)
    right_layout:add(wifiwrapper)
    right_layout:add(arr9)
    right_layout:add(tclockwrapper)
    right_layout:add(arr9)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)
    layout:set_middle(mytasklist[s])

    mywibox[s]:set_widget(layout)
end
-- }}}



-- {{{ Shifty initialization
shifty.taglist = mytaglist
shifty.init()
-- }}}



-- {{{ Mouse bindings
--[[root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 5, awful.tag.viewnext),
    awful.button({ }, 4, awful.tag.viewprev)
))--]]
-- }}}


local capslock_naughty = nil
function toggle_capslock ()
    if capslock_naughty == nil then
        capslock_naughty = naughty.notify({ text = "Caps Lock", timeout = 0 })
    else
        naughty.destroy(capslock_naughty)
        capslock_naughty = nil
    end
end
        

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- MEDIA KEYS
    awful.key({ }, "XF86MonBrightnessUp", function ()
       awful.util.spawn("xbacklight -inc 15") end),
    awful.key({ }, "XF86MonBrightnessDown", function ()
       awful.util.spawn("xbacklight -dec 15") end),
    awful.key({ }, "XF86ScreenSaver", function ()
       awful.util.spawn("slock")
       awful.util.spawn("xset dpms force off")  end),
    awful.key({ }, "XF86AudioRaiseVolume", function ()
       awful.util.spawn("amixer sset Master unmute")
       awful.util.spawn("amixer set Master 3%+") end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
       awful.util.spawn("amixer sset Master unmute")
       awful.util.spawn("amixer set Master 3%-") end),
    awful.key({ }, "XF86AudioMute", function ()
       awful.util.spawn("amixer sset Master toggle") end),
    awful.key({ }, "XF86Display", function ()
       awful.util.spawn(os.getenv("HOME") .. "/git/linux-scripts/monitor") end),
    awful.key({ }, "XF86Sleep", function ()
        awful.util.spawn("slock") end),
    awful.key({ }, "Print", function ()
        awful.util.spawn("scrot -e 'mv $f /data/image/screenshots/archlinux'") end),
    awful.key({ }, "Caps_Lock", toggle_capslock),
    awful.key({"Shift"}, "Caps_Lock", toggle_capslock),
    awful.key({"Control"}, "Caps_Lock", toggle_capslock),
    awful.key({modkey}, "Caps_Lock", toggle_capslock),
    awful.key({ modkey, }, "F3",     function () 
        local fh = io.popen("xbacklight -get | cut -d '.' -f 1")
        local light = fh:read("*l")
        fh:close()
        if light == "0" then
            awful.util.spawn(os.getenv("HOME") .. "/git/linux-scripts/backlight")
        else
            awful.util.spawn("xbacklight -set 0 -time 0")
        end
    end),
    
    -- TAG NAVIGATION
    awful.key({ modkey, }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey, }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore),

    -- CLIENT NAVIGATION
    awful.key({ modkey, }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
     awful.key({ modkey,           }, "w",      function ()
                    info = true
                    awful.prompt.run({ fg_cursor = "black", bg_cursor="gray", prompt = "<span color='#008DFA'>Wiki:</span> " },
                    mypromptbox[mouse.screen].widget,
                    function (word)
                        word = string.gsub(word, " ", "\\ ")
                        awful.util.spawn("firefox -new-tab http://en.wikipedia.org/wiki/" .. word)
                    end)
                end),

   awful.key({ modkey, "Shift"   }, "w",      function ()
                    info = true
                    awful.prompt.run({ fg_cursor = "black", bg_cursor="gray", prompt = "<span color='#008DFA'>ArchWiki:</span> " },
                    mypromptbox[mouse.screen].widget,
                    function (word)
                        word = string.gsub(word, " ", "\\ ")
                        awful.util.spawn("firefox -new-tab http://wiki.archlinux.org/index.php/" .. word)
                    end)
                end),

    awful.key({ modkey, "Shift"   }, "q", function () mymainmenu:show() end),
--awful.key({ modkey,           }, "w", function () mymainmenu:show() end),
--    awful.key({ modkey, "Control" }, "n", awful.client.restore),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey, "Shift"   }, "u", function () while awful.client.urgent.get() ~= nil do awful.client.urgent.get().urgent = false end end),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- LAYOUT MANIPULATION
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
   
    -- PROGRAMS
    awful.key({ modkey }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey }, "e",      function () awful.util.spawn("thunar -- " .. os.getenv("HOME") .. "/Desktop") end),
    awful.key({ modkey }, "q",      function () menubar.show() end),
    --awful.key({ modkey }, "r",      function () mypromptbox[mouse.screen]:run() end),  
    awful.key({ modkey }, "r",      function () awful.util.spawn("bashrun") end),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
   
    -- SHIFTY
    awful.key({ modkey, "Shift"   }, "d", shifty.del),
    awful.key({ modkey, "Shift"   }, "n", shifty.send_prev),
    awful.key({ modkey,           }, "n", shifty.send_next),
    awful.key({ modkey, "Control" }, "d",
              function ()
                  local t = awful.tag.selected()
                  local s = awful.util.cycle(screen.count(), awful.tag.getscreen(t) + 1)
                  awful.tag.history.restore()
                  t = shifty.tagtoscr(s, t)
                  awful.tag.viewonly(t)
                end),
    awful.key({ modkey,           }, "a", shifty.add),
    awful.key({ modkey, "Shift"   }, "r", shifty.rename),
    awful.key({ modkey, "Shift"   }, "a", function () shifty.add({nopopup = true}) end),
 
    -- MISC
    -- show/hide wibox
    awful.key({ modkey, "Shift"   }, "f",      function () awful.util.spawn_with_shell("notify-send -t 20000 \"$(fortune)\"") end),
    awful.key({ modkey,           }, "b",      function () mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible end),
    awful.key({ modkey,           }, "o",      function () awful.screen.focus(mouse.screen % screen.count() + 1) end),      -- cycles through screens. note: screens are 1-based
    awful.key({ modkey,           }, "d",      function ()
                    info = true
                    awful.prompt.run({ fg_cursor = "black", bg_cursor="gray", prompt = "<span color='#008DFA'>Define:</span> " },
                    mypromptbox[mouse.screen].widget,
                    function (word)
                        local f = io.popen("dict -d wn " .. word .. " 2>&1")
                        local fr = ""
                        for line in f:lines() do
                            fr = fr .. line .. '\n'
                        end
                        f:close()
                        naughty.notify({ text = fr, timeout = 90, width = 400 })
                    end, nil, awful.util.getdir("cache") .. "/dict")
                end),

   awful.key({ modkey,           }, "c",      function ()
                    info = true
                    awful.prompt.run({ fg_cursor = "black", bg_cursor="gray", prompt = "<span color='#008DFA'>Calc:</span> " },
                    mypromptbox[mouse.screen].widget,
                    function (word)
                        local f = io.popen("calc " .. word)
                        local fr = word .. "="
                        for line in f:lines() do
                            fr = fr .. line
                        end
                        f:close()
                        naughty.notify({ text = fr, timeout = 30})
                    end, nil, awful.util.getdir("cache") .. "/dict")
                end),


    -- awesome
    awful.key({ modkey, "Control" }, "r",      awesome.restart)
    --awful.key({ modkey, "Shift"   }, "q",      awesome.quit)
)

clientkeys = awful.util.table.join(
    --awful.key({ modkey, "Shift"   }, "Return", function (c)
     --                                               awful.util.spawn(terminal)
      --                                              c:swap(awful.client.getmaster())
       --                                        end),
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, "Shift"   }, "o",      awful.client.movetoscreen                        ),

--    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
--    awful.key({ modkey,           }, "n",
--        function (c)
--            -- The client currently has the input focus, so it cannot be
--            -- minimized, since minimized clients can't have the focus.
--            c.minimized = true
--        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)



-- {{{ Rules
awful.rules.rules = {
    { rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_color,
            focus = awful.client.focus.filter,
            keys = clientkeys,
            buttons = clientbuttons,
            size_hints_honor = false
        }
    },
    { rule = { name = "File Operation Progress" },
        properties = { 
            floating = true
        }
    }
}
-- }}}



-- SHIFTY
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey

-- Bind key numbers to tags
for i = 1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                      awful.tag.viewonly(shifty.getpos(i))
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      awful.tag.viewtoggle(shifty.getpos(i))
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local t = shifty.getpos(i)
                          awful.client.movetotag(t)
                          awful.tag.viewonly(t)
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          awful.client.toggletag(shifty.getpos(i))
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}



-- {{{ Signals
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others iSuperTuxKarttting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus",
                    function(c)
                      c.border_color = beautiful.border_focus

                      if not (c.class    == "Vlc")
                        and not (c.class == "Mirage")
                        and not (c.class == "Plugin-container")
                        and not (c.class == "supertuxkart")
                        --and not (c.name  == "GNU Image Manipulation Program")
                        and not (c.name == "SRF Player - Mozilla Firefox")
                        and not (c.name == "Sacred")
                        and not (c.class == "Ristretto")
                      then
                        c.opacity = 0.91
                    else
                        c.opacity = 1
                      end
                    end)
client.connect_signal("unfocus",
                    function(c)
                      c.border_color = beautiful.border_normal
                      if not (c.class    == "Vlc") 
                        and not (c.class == "Mirage")
                        and not (c.class == "Plugin-container")
                        --and not (c.name  == "GNU Image Manipulation Program")
                        and not (c.name == "SRF Player - Mozilla Firefox")
                        then
                          c.opacity = 0.7
                      else
                          c.opacity = 1
                        end
                    end)
-- }}}

function init_capslock() 
    local handle = io.popen("xset q | grep Caps | cut -d ' ' -f 10")
    local data = handle:read("*l")
    handle:close()
    
    if data == "on" then
        capslock_naughty = naughty.notify({ text = "Caps Lock", timeout = 0 })
    end
end

init_capslock()

