# Linux-scripts
A collection of miscellaneous scripts for Linux. Many are simple wrapper scripts e.g. to grant root access for specific commands or to map them to keys.

Included are scripts that I use for the system monitor tool [conky](http://conky.sourceforge.net/) and [awesomeWM](http://awesome.naquadah.org/)

# License
All scripts are written by me if not specified otherwise. They are licensed under APL 2.0 (see the [license](https://github.com/furgerf/linux-scripts/blob/master/LICENSE) file).

# Usage
Depends on the scripts. Most are very short and simple so usage is self-explanatory.

# Descriptions
Some of the more interesting scripts are described here.

## conky
### clementine-dbus
Reads information via dbus about currently playing music from Clementine. Displays 5 lines as well as the album cover in conky format.

### conkycolor
A script that colorizes a value depending on where it lies between a min and a max value. The color used is as far between the two passed colors as the value is between min and max.

### gcalcli.lua
Lua script that uses gcalcli to access the google calendar API. Information about a number of upcoming appointments is gathered and formatted to be displayed in conky.

### get_wan
Checks whether a WAN address is available and prints it or a text informing about no connection.

## awesome
### refresh_database
Helper-script which merely updates the package database. This is useful for privileges via the sudoers file.


## Other
### backlight
Checks AC connection and sets backlight accordingly.

### biodata
Checks whether a file has been modified today. If not, a reminder is spoken and the file is opened.

### compton-toggle
Toggles compton; mapped to a hotkey.

### cpu_toggle_govenor
Toggles between performance and powersave CPU govenor.

### fix_firefox_flash
Runs simple replacement which prevents fullscreen flash windows from closing when they lose focus. Must be applied after updates.

### git-pull/git-status
Recursively searches for directories containing git repositories and asks the user whether the repo should be pulled/notifies the user if local commits exist.

### logcat
Calls logcat-colorize with parameters (like path to adb logcat).

### logcat-colorize
Slightly adjusted source found [here](https://bitbucket.org/brunobraga/logcat-colorize) and compiled. Called by logcat.

### monitor
Uses xrandr to toggle second monitor. Mapped to key.

### multigource
Merges the logs from several repos into one and runs gource on the combined log.

### new-day
Adds "day separator" line in my cron history log.

### set_tpacpi
Checks whether battery thresholds are set, if not then they're set.

### texcount.pl
Perl script from [here](http://app.uio.no/ifi/texcount/) that counts the words in .tex source files.

### tex-count-recursive
Recursively calls texcount.pl on .tex files in directory and subdirectories and sums up the words. Used for multi-source tex projects.

### timetable.lua
Collects the lecture hours from the Coventry University timetable webpage and creates corresponding entries in a Google calendar.

### translate
Translates highlighted text to german and displays the result with naughty.

### winboot
Powers off or hibernates and restarts directly to the "windows" Syslinux label.

# Contact
mystyfly@gmail.com

