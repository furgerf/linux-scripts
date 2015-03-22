-- {{{ Main
theme = {}

theme.default_themes_path = "/usr/share/awesome/themes"
theme.colors = {}

theme.colors.white   = "#ffffff"
theme.colors.grey    = "#aaaaaa"
theme.colors.light4  = "#D1E9F6"
theme.colors.light3  = "#A2D4ED"
theme.colors.light2  = "#74BEE3"
theme.colors.light1  = "#45A9DA"
theme.colors.arch    = "#1793d1"
theme.colors.dark1   = "#1276A7"
theme.colors.dark2   = "#0E587D"
theme.colors.dark3   = "#093B54"
theme.colors.dark4   = "#051D2A"
theme.colors.black   = "#000000"

theme.colors.pink    = "#ff0022"
-- }}}

-- {{{ Styles
theme.font      = "DejaVu Sans 8"
-- }}}

-- {{{ Colors
theme.fg_normal  = theme.colors.grey
theme.bg_normal  = theme.colors.black

theme.fg_focus   = theme.colors.black
theme.bg_focus   = theme.colors.arch

theme.fg_urgent  = theme.colors.dark2
theme.bg_urgent  = theme.colors.light4

theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Extra Colors
theme.cpu_bg      = theme.bg_normal
theme.cpu_fg      = theme.fg_normal
theme.hdd_bg      = theme.bg_normal
theme.batt_bg     = theme.bg_normal
theme.net_bg      = theme.bg_normal
theme.mem_bg      = theme.bg_normal
theme.vol_bg      = theme.bg_normal
-- }}}

-- {{{ Borders
theme.border_width  = 1
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_urgent
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = theme.colors.pink
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "150"

-- invert normal colors to stand out (since window behind menu is likely focused)
theme.menu_bg_normal = theme.bg_focus
theme.menu_fg_normal = theme.fg_focus
theme.menu_bg_focus = theme.bg_normal
theme.menu_fg_focus = theme.fg_normal

theme.menu_border_color = theme.colors.dark4
theme.menu_border_width = 1
-- }}}

--{{--- Theme icons ------------------------------------------------------------------------------------------
local themes_dir = "/usr/share/awesome/themes"

theme.awesome_icon                              = themes_dir .. "/archdove/icons/awesome-icon.png"
theme.clear_icon                                = themes_dir .. "/archdove/icons/clear.png"
-- theme.clear_icon                                = themes_dir .. "/archdove/icons/llauncher.png"
theme.menu_submenu_icon                         = themes_dir .. "/archdove/icons/submenu.png"
theme.tasklist_floating_icon                    = themes_dir .. "/archdove/icons/floatingm.png"
theme.titlebar_close_button_focus               = themes_dir .. "/archdove/icons/close_focus.png"
theme.titlebar_close_button_normal              = themes_dir .. "/archdove/icons/close_normal.png"
theme.titlebar_ontop_button_focus_active        = themes_dir .. "/archdove/icons/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = themes_dir .. "/archdove/icons/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = themes_dir .. "/archdove/icons/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = themes_dir .. "/archdove/icons/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = themes_dir .. "/archdove/icons/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = themes_dir .. "/archdove/icons/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = themes_dir .. "/archdove/icons/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = themes_dir .. "/archdove/icons/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = themes_dir .. "/archdove/icons/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = themes_dir .. "/archdove/icons/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = themes_dir .. "/archdove/icons/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = themes_dir .. "/archdove/icons/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = themes_dir .. "/archdove/icons/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = themes_dir .. "/archdove/icons/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_dir .. "/archdove/icons/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_dir .. "/archdove/icons/maximized_normal_inactive.png"
theme.taglist_squares_sel                       = themes_dir .. "/archdove/icons/square_sel.png"
theme.taglist_squares_unsel                     = themes_dir .. "/archdove/icons/square_unsel.png"
theme.layout_floating                           = themes_dir .. "/archdove/icons/floating.png"
theme.layout_tile                               = themes_dir .. "/archdove/icons/tile.png"
theme.layout_tileleft                           = themes_dir .. "/archdove/icons/tileleft.png"
theme.layout_tilebottom                         = themes_dir .. "/archdove/icons/tilebottom.png"
theme.layout_tiletop                            = themes_dir .. "/archdove/icons/tiletop.png"
theme.widget_battery                            = themes_dir .. "/archdove/icons/battery.png"
theme.widget_mem                                = themes_dir .. "/archdove/icons/mem.png"
theme.widget_cpu                                = themes_dir .. "/archdove/icons/cpu.png"
theme.widget_temp                               = themes_dir .. "/archdove/icons/temp.png"
theme.widget_net                                = themes_dir .. "/archdove/icons/net.png"
theme.widget_hdd                                = themes_dir .. "/archdove/icons/hdd.png"
theme.widget_music                              = themes_dir .. "/archdove/icons/music.png"
theme.widget_task                               = themes_dir .. "/archdove/icons/task.png"
theme.widget_mail                               = themes_dir .. "/archdove/icons/mail.png"
theme.arr1                                      = themes_dir .. "/archdove/icons/arr1.png"
theme.arr2                                      = themes_dir .. "/archdove/icons/arr2.png"
theme.arr3                                      = themes_dir .. "/archdove/icons/arr3.png"
theme.arr4                                      = themes_dir .. "/archdove/icons/arr4.png"
theme.arr5                                      = themes_dir .. "/archdove/icons/arr5.png"
theme.arr6                                      = themes_dir .. "/archdove/icons/arr6.png"
theme.arr7                                      = themes_dir .. "/archdove/icons/arr7.png"
theme.arr8                                      = themes_dir .. "/archdove/icons/arr8.png"
theme.arr9                                      = themes_dir .. "/archdove/icons/arr9.png"
theme.arr0                                      = themes_dir .. "/archdove/icons/arr0.png"
theme.sound_1_25				= themes_dir .. "/archdove/icons/sound_1-25.png"
theme.sound_26_50				= themes_dir .. "/archdove/icons/sound_26-50.png"
theme.sound_51_75				= themes_dir .. "/archdove/icons/sound_51-75.png"
theme.sound_76_100				= themes_dir .. "/archdove/icons/sound_76-100.png"
theme.sound_mute				= themes_dir .. "/archdove/icons/sound_mute.png"
theme.battery1					= themes_dir .. "/archdove/icons/battery1.png"
theme.battery2					= themes_dir .. "/archdove/icons/battery2.png"
theme.battery3					= themes_dir .. "/archdove/icons/battery3.png"
theme.battery4					= themes_dir .. "/archdove/icons/battery4.png"
theme.battery5					= themes_dir .. "/archdove/icons/battery5.png"
theme.battery6					= themes_dir .. "/archdove/icons/battery6.png"
theme.battery7					= themes_dir .. "/archdove/icons/battery7.png"
theme.battery8					= themes_dir .. "/archdove/icons/battery8.png"
theme.battery9					= themes_dir .. "/archdove/icons/battery9.png"
theme.battery10					= themes_dir .. "/archdove/icons/battery10.png"
theme.battery11					= themes_dir .. "/archdove/icons/battery11.png"
theme.wifinone					= themes_dir .. "/archdove/icons/nowifi.png"
theme.wifi1					= themes_dir .. "/archdove/icons/wifi1.png"
theme.wifi2					= themes_dir .. "/archdove/icons/wifi2.png"
theme.wifi3					= themes_dir .. "/archdove/icons/wifi3.png"
theme.wifi4					= themes_dir .. "/archdove/icons/wifi4.png"
theme.wifi5					= themes_dir .. "/archdove/icons/wifi5.png"
theme.ethernet              = themes_dir .. "/archdove/icons/ethernet.png"
theme.config_icon				= themes_dir .. "/archdove/icons/config.png"
theme.explorer_icon				= themes_dir .. "/archdove/icons/explorer.png"
theme.terminal_icon				= themes_dir .. "/archdove/icons/terminal.png"


-- {{{ Layout
theme.layout_fairv      = theme.default_themes_path.."/archdove/layouts/fairv.png"
theme.layout_fairh      = theme.default_themes_path.."/archdove/layouts/fairh.png"
theme.layout_spiral     = theme.default_themes_path.."/archdove/layouts/spiral.png"
theme.layout_dwindle    = theme.default_themes_path.."/archdove/layouts/dwindle.png"
theme.layout_max        = theme.default_themes_path.."/archdove/layouts/max.png"
theme.layout_fullscreen = theme.default_themes_path.."/archdove/layouts/fullscreen.png"
theme.layout_magnifier  = theme.default_themes_path.."/archdove/layouts/magnifier.png"
theme.layout_floating                           = themes_dir .. "/archdove/icons/floating.png"
theme.layout_tile                               = themes_dir .. "/archdove/icons/tile.png"
theme.layout_tileleft                           = themes_dir .. "/archdove/icons/tileleft.png"
theme.layout_tilebottom                         = themes_dir .. "/archdove/icons/tilebottom.png"
theme.layout_tiletop                            = themes_dir .. "/archdove/icons/tiletop.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = theme.default_themes_path.."/archdove/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.default_themes_path.."/archdove/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active  = theme.default_themes_path.."/archdove/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.default_themes_path.."/archdove/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme.default_themes_path.."/archdove/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.default_themes_path.."/archdove/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active  = theme.default_themes_path.."/archdove/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.default_themes_path.."/archdove/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme.default_themes_path.."/archdove/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.default_themes_path.."/archdove/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active  = theme.default_themes_path.."/archdove/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.default_themes_path.."/archdove/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme.default_themes_path.."/archdove/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.default_themes_path.."/archdove/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active  = theme.default_themes_path.."/archdove/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.default_themes_path.."/archdove/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default_themes_path.."/archdove/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_themes_path.."/archdove/titlebar/maximized_normal_inactive.png"
-- }}}

return theme

