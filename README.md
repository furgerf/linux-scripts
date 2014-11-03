linux-scripts
=============

Miscellaneous Scripts for Linux. Includes scripts I use for the system monitor tool conky and the awesome window manager

conky
-----

### .conkyrc
My configuration file for conky.

### clementine-dbus
Reads information about currently playing music from Clementine. Uses dbus and displays 5 lines as well as album cover.

### conkycolor
Used to colorize a value depending on where it lies between a min and a max value. The color used is as far between the two passed colors as the value is between min and max.

### get_wan
Checks whether a WAN address is available and prints it or a text informing about no connection.

### google_calendar.lua
Lua script that checks google calendars for the next five upcoming events and prints them in order.


awesome
-------

### rc.lua
My configuration file for awesome.

### calendar2.lua
Awesome module that adds a calendar to a widget using naughty.

### refresh_database
Helper-script which merely updates the package database. This is useful for privileges via the sudoers file.


Other
-----

### backlight
Checks AC connection and sets backlight accordingly. Used in .xinitrc.

### cpu_toggle_govenor
Toggles between performance and powersave CPU govenor. Triggered by click on awesome widget.

### fix_firefox_flash
Runs simple replacement which prevents fullscreen flash windows from closing when they lose focus. Must be applied after updates.

### ilias-connect
After a delay, connects to ilias webfolders if connected to the HSLU wifi. Used in .xinitrc.

### logcat
Calls logcat-colorize with parameters (like path to adb logcat).

### logcat-colorize
Adjusted and compiled from someone else. Called by logcat.

### monitor
Uses xrandr to toggle secondary monitor. Mapped to key.

### multigource
Merges the logs from several repos into one and runs gource on the combined log.

### set_tpacpi
Checks whether battery thresholds are set, if not then they're set. Used in .xinitrc.

### timetable.lua
Collects the lecture hours from the Coventry University timetable webpage and creates corresponding entries in a Google calendar.

### translate
Translates highlighted text to german and displays the result with naughty.


Contact
-------
mystyfly@gmail.com

