-- {{{ Main
theme = {}

theme.default_themes_path = "/usr/share/awesome/themes"
theme.colors = {}
theme.colors.base3   = "#000000ff"
theme.colors.base2   = "#073642ff"
theme.colors.base1   = "#eeeeeeee"
theme.colors.base0   = "#657b83ff"
theme.colors.base00  = "#839496ff"
theme.colors.base01  = "#93a1a1ff"
theme.colors.base02  = "#ffffffff"
theme.colors.base03  = "#000000ff"
theme.colors.yellow  = "#b58900ff"
theme.colors.orange  = "#cb4b16ff"
theme.colors.red     = "#dc322fff"
theme.colors.magenta = "#d33682ff"
theme.colors.violet  = "#6c71c4ff"
theme.colors.blue    = "#268bd2ff"
theme.colors.cyan    = "#2aa198ff"
theme.colors.green   = "#859900ff"
-- }}}

-- {{{ Styles
theme.font      = "Menlo for Powerline 8"

-- {{{ Colors
theme.fg_normal  = theme.colors.base02
theme.fg_focus   = theme.colors.base03
theme.fg_urgent  = theme.colors.base3
theme.bg_normal  = theme.colors.base3
theme.bg_focus   = theme.colors.base1
theme.bg_urgent  = theme.colors.red
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_urgent
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = theme.colors.green
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "150"
-- }}}

--{{--- Theme icons ------------------------------------------------------------------------------------------
local themes_dir = "/usr/share/awesome/themes"

theme.awesome_icon                              = themes_dir .. "/archdove/icons/powerarrow/awesome-icon.png"
theme.clear_icon                                = themes_dir .. "/archdove/icons/powerarrow/clear.png"
-- theme.clear_icon                                = themes_dir .. "/archdove/icons/powerarrow/llauncher.png"
theme.menu_submenu_icon                         = themes_dir .. "/archdove/icons/powerarrow/submenu.png"
theme.tasklist_floating_icon                    = themes_dir .. "/archdove/icons/powerarrow/floatingm.png"
theme.titlebar_close_button_focus               = themes_dir .. "/archdove/icons/powerarrow/close_focus.png"
theme.titlebar_close_button_normal              = themes_dir .. "/archdove/icons/powerarrow/close_normal.png"
theme.titlebar_ontop_button_focus_active        = themes_dir .. "/archdove/icons/powerarrow/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = themes_dir .. "/archdove/icons/powerarrow/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = themes_dir .. "/archdove/icons/powerarrow/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = themes_dir .. "/archdove/icons/powerarrow/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = themes_dir .. "/archdove/icons/powerarrow/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = themes_dir .. "/archdove/icons/powerarrow/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = themes_dir .. "/archdove/icons/powerarrow/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = themes_dir .. "/archdove/icons/powerarrow/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = themes_dir .. "/archdove/icons/powerarrow/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = themes_dir .. "/archdove/icons/powerarrow/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = themes_dir .. "/archdove/icons/powerarrow/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = themes_dir .. "/archdove/icons/powerarrow/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = themes_dir .. "/archdove/icons/powerarrow/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = themes_dir .. "/archdove/icons/powerarrow/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_dir .. "/archdove/icons/powerarrow/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_dir .. "/archdove/icons/powerarrow/maximized_normal_inactive.png"
theme.taglist_squares_sel                       = themes_dir .. "/archdove/icons/powerarrow/square_sel.png"
theme.taglist_squares_unsel                     = themes_dir .. "/archdove/icons/powerarrow/square_unsel.png"
theme.layout_floating                           = themes_dir .. "/archdove/icons/powerarrow/floating.png"
theme.layout_tile                               = themes_dir .. "/archdove/icons/powerarrow/tile.png"
theme.layout_tileleft                           = themes_dir .. "/archdove/icons/powerarrow/tileleft.png"
theme.layout_tilebottom                         = themes_dir .. "/archdove/icons/powerarrow/tilebottom.png"
theme.layout_tiletop                            = themes_dir .. "/archdove/icons/powerarrow/tiletop.png"
theme.widget_battery                            = themes_dir .. "/archdove/icons/powerarrow/battery.png"
theme.widget_mem                                = themes_dir .. "/archdove/icons/powerarrow/mem.png"
theme.widget_cpu                                = themes_dir .. "/archdove/icons/powerarrow/cpu.png"
theme.widget_temp                               = themes_dir .. "/archdove/icons/powerarrow/temp.png"
theme.widget_net                                = themes_dir .. "/archdove/icons/powerarrow/net.png"
theme.widget_hdd                                = themes_dir .. "/archdove/icons/powerarrow/hdd.png"
theme.widget_music                              = themes_dir .. "/archdove/icons/powerarrow/music.png"
theme.widget_task                               = themes_dir .. "/archdove/icons/powerarrow/task.png"
theme.widget_mail                               = themes_dir .. "/archdove/icons/powerarrow/mail.png"
theme.arr1                                      = themes_dir .. "/archdove/icons/powerarrow/arr1.png"
theme.arr2                                      = themes_dir .. "/archdove/icons/powerarrow/arr2.png"
theme.arr3                                      = themes_dir .. "/archdove/icons/powerarrow/arr3.png"
theme.arr4                                      = themes_dir .. "/archdove/icons/powerarrow/arr4.png"
theme.arr5                                      = themes_dir .. "/archdove/icons/powerarrow/arr5.png"
theme.arr6                                      = themes_dir .. "/archdove/icons/powerarrow/arr6.png"
theme.arr7                                      = themes_dir .. "/archdove/icons/powerarrow/arr7.png"
theme.arr8                                      = themes_dir .. "/archdove/icons/powerarrow/arr8.png"
theme.arr9                                      = themes_dir .. "/archdove/icons/powerarrow/arr9.png"
theme.arr0                                      = themes_dir .. "/archdove/icons/powerarrow/arr0.png"
theme.sound_1_25				= themes_dir .. "/archdove/icons/powerarrow/sound_1-25.png"
theme.sound_26_50				= themes_dir .. "/archdove/icons/powerarrow/sound_26-50.png"
theme.sound_51_75				= themes_dir .. "/archdove/icons/powerarrow/sound_51-75.png"
theme.sound_76_100				= themes_dir .. "/archdove/icons/powerarrow/sound_76-100.png"
theme.sound_mute				= themes_dir .. "/archdove/icons/powerarrow/sound_mute.png"
theme.battery1					= themes_dir .. "/archdove/icons/powerarrow/battery1.png"
theme.battery2					= themes_dir .. "/archdove/icons/powerarrow/battery2.png"
theme.battery3					= themes_dir .. "/archdove/icons/powerarrow/battery3.png"
theme.battery4					= themes_dir .. "/archdove/icons/powerarrow/battery4.png"
theme.battery5					= themes_dir .. "/archdove/icons/powerarrow/battery5.png"
theme.battery6					= themes_dir .. "/archdove/icons/powerarrow/battery6.png"
theme.battery7					= themes_dir .. "/archdove/icons/powerarrow/battery7.png"
theme.battery8					= themes_dir .. "/archdove/icons/powerarrow/battery8.png"
theme.battery9					= themes_dir .. "/archdove/icons/powerarrow/battery9.png"
theme.battery10					= themes_dir .. "/archdove/icons/powerarrow/battery10.png"
theme.battery11					= themes_dir .. "/archdove/icons/powerarrow/battery11.png"
theme.wifinone					= themes_dir .. "/archdove/icons/powerarrow/nowifi.png"
theme.wifi1					= themes_dir .. "/archdove/icons/powerarrow/wifi1.png"
theme.wifi2					= themes_dir .. "/archdove/icons/powerarrow/wifi2.png"
theme.wifi3					= themes_dir .. "/archdove/icons/powerarrow/wifi3.png"
theme.wifi4					= themes_dir .. "/archdove/icons/powerarrow/wifi4.png"
theme.wifi5					= themes_dir .. "/archdove/icons/powerarrow/wifi5.png"
theme.ethernet              = themes_dir .. "/archdove/icons/powerarrow/ethernet.png"
theme.config_icon				= themes_dir .. "/archdove/icons/powerarrow/config.png"
theme.explorer_icon				= themes_dir .. "/archdove/icons/powerarrow/explorer.png"
theme.terminal_icon				= themes_dir .. "/archdove/icons/powerarrow/terminal.png"


-- {{{ Layout
theme.layout_fairv      = theme.default_themes_path.."/zenburn/layouts/fairv.png"
theme.layout_fairh      = theme.default_themes_path.."/zenburn/layouts/fairh.png"
theme.layout_spiral     = theme.default_themes_path.."/zenburn/layouts/spiral.png"
theme.layout_dwindle    = theme.default_themes_path.."/zenburn/layouts/dwindle.png"
theme.layout_max        = theme.default_themes_path.."/zenburn/layouts/max.png"
theme.layout_fullscreen = theme.default_themes_path.."/zenburn/layouts/fullscreen.png"
theme.layout_magnifier  = theme.default_themes_path.."/zenburn/layouts/magnifier.png"
theme.layout_floating                           = themes_dir .. "/archdove/icons/powerarrow/floating.png"
theme.layout_tile                               = themes_dir .. "/archdove/icons/powerarrow/tile.png"
theme.layout_tileleft                           = themes_dir .. "/archdove/icons/powerarrow/tileleft.png"
theme.layout_tilebottom                         = themes_dir .. "/archdove/icons/powerarrow/tilebottom.png"
theme.layout_tiletop                            = themes_dir .. "/archdove/icons/powerarrow/tiletop.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = theme.default_themes_path.."/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.default_themes_path.."/zenburn/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active  = theme.default_themes_path.."/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.default_themes_path.."/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme.default_themes_path.."/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.default_themes_path.."/zenburn/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active  = theme.default_themes_path.."/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.default_themes_path.."/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme.default_themes_path.."/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.default_themes_path.."/zenburn/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active  = theme.default_themes_path.."/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.default_themes_path.."/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme.default_themes_path.."/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.default_themes_path.."/zenburn/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active  = theme.default_themes_path.."/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.default_themes_path.."/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default_themes_path.."/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_themes_path.."/zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

-- {{{ Extra Colors
theme.binclock_bg = "222222"
theme.cpu_bg      = "313131"
theme.hdd_bg      = "313131"
theme.batt_bg     = "313131"
theme.net_bg      = "313131"
theme.mem_bg      = "222222"
theme.vol_bg      = "313131"
-- }}}

return theme
