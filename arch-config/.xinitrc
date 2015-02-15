#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exports
export TERM="xterm"
export PAGER="/bin/less"

sudo dhcpcd -b -q enp0s25

# backlight
$HOME/git/linux-scripts/backlight

# monitor
xrandr --output VGA1 --off ; $HOME/git/linux-scripts/monitor

# conky
sleep 30 && conky -c $HOME/git/linux-scripts/conky/.conkyrc -d &

# start keyring daemon UNUSED
#eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcsll,secrets,ssh) ; export GPG_AGENT_INFO SSH_AUTH_SOCK

# set shortcut to kill X session
setxkbmap -option caps:swapescape,terminate:ctrl_alt_bksp

# NM UI
nm-applet &

# TP battery tresholds
$HOME/git/linux-scripts/set_tpacpi

# dropbox
dropbox &

# set dbus address for cron stuff
$HOME/git/linux-scripts/set_dbus_address

# composite manager
compton --backend glx --paint-on-overlay --vsync opengl-swc -fb -D5

# start thunar in daemon mode
thunar --daemon &

# start udiskie for automounting usb's
udiskie -2 -s &

# adjust keyboard repeat rate
xset r rate 250 35

# load modified key map
#if [ -s ~/.Xmodmap ]; then
#    xmodmap ~/.Xmodmap
#fi

# start awesome wm
exec awesome
#exec ck-launch-session awesome
#exec ck-launch-session dbus-launch awesome

