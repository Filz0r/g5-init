#!/bin/sh

#killall redshift*
#setxkbmap -option caps:swapescape
picom --experimental-backends --config /home/filipe/.config/picom/picom.conf &
nm-applet &
blueman-applet &
numlockx &
transmission-remote-gtk &
bitwarden-desktop &
kdeconnect-indicator & 
dunst &
/usr/bin/emacs --daemon &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#~/.config/polybar/launch.sh &
#nitrogen --restore &
#xss-lock --transfer-sleep-lock -- i3lock --nofork &
redshift-gtk -l 38.61667:-9.08333 &
flameshot &
#snapclient  --player pulse --logsink system -h 192.168.1.199 -p 1704 &
~/scripts/screen/auto-screens.sh
#killall pasystray
#~/scripts/spotify-fix.sh
# pasystray &