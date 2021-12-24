#!/usr/bin/env bash

##
## Filipe Figueiredo - Copyright - 2021
##
## This script is responsible for launching/ reloading my entire graphical
## enviroment, while being window manager agnostic.
## This means that the script is responsible for setting screen layouts,
## audio inputs and sources, and finally launch or check if the apps
## are running when changing "modes".
## The reason why I need "modes" in my setup is because I run a laptop,
## as my main computer, plugged into 2 monitors with a mouse, keyboard
## and speakers and headphones, this is what I call "Desktop mode",
## where my laptop is tucked away with the monitor and speakers disabled.
## Then on laptop mode it turns the laptop screen and speakers back on.
## If you want to use this script you need to make sure you also use the
## 'audio.sh' script to handle the configuration of the audio, as I did
## not want to centralize everything into one gigantic script,
## I'm not that crazy.
## Every command you see commented can be used for debugging, just uncomment
## what you think is breaking the script and work from there.
##
## Variables
CONNECTIONS=$(xrandr | grep " connected " | awk '{ print $1}' | wc -l)
##
## Functions
polybar_handler() {
    desktop="$DESKTOP_SESSION"

    case $desktop in
        i3)
            BAR="topbar"
            ;;
        qtile)
            BAR="qtile"
            ;;
    esac

    case "$1" in
        "launch")
            for m in $(polybar --list-monitors | cut -d":" -f1); do
                MONITOR=$m polybar --reload $BAR &
##                sleep 1
            done
            ;;
        "reload")
            polybar-msg cmd restart
            ;;
        *)
            echo "me broke cuz u idiot"
            ;;
    esac
}
##
## This function must only call the apps that you want to launch at start
## and nothing else, this means on i3 you call this with
## 'exec_once --no-startup-id $PATH_TO_SCRIPT "launch"'
##
app_launch() {
##  Apps that run at launch
    picom --experimental-backends --config /home/filipe/.config/picom/picom.conf & disown
    nm-applet & disown
    blueman-applet & disown
    numlockx & disown
    transmission-remote-gtk & disown
    bitwarden-desktop & disown
    kdeconnect-indicator & disown
    dunst & disown
    /usr/bin/emacs --daemon & disown
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & disown
    redshift-gtk -l 38.61667:-9.08333 & disown
    flameshot & disown
    optimus-manager-qt & disown
    nextcloud & disown
## Polybar launch
    polybar_handler "launch"
}
##
## This function is what is responsible for swapping between modes
## When there is only 1 connected display, this means that only the laptop
## screen is available, so we only enable one output in xrandr  and the
## audio script will enable the built-in audio, nitrogen will set the
## horizontal wallpaper on the screen 1 set to fill and finally reload
## pollybar that will be forced to run on the only screen available,
## the keyboard command can be deleted as this is optional.
##
swap_mode() {
    case $CONNECTIONS in
        1)
            xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --refresh 144
                
##            sleep 1
            ~/scripts/audio.sh "launch-audio"
            nitrogen --restore & disown
            polybar_handler "launch"
            setxkbmap -option caps:swapescape
            ;;
        3)a
            xrandr --output HDMI-1-0 --mode 1920x1080 --pos 2560x0 --rotate left \
                --output eDP-1 --off \
                --output DP-1 --primary --mode 2560x1080 --refresh 75 --pos 0x595 --rotate normal 
                
##            sleep 1
            ~/scripts/audio.sh "launch-audio"
            nitrogen --restore & disown
            polybar_handler "launch"
            setxkbmap -option caps:swapescape
            ;;
        *)
            echo "Invalid number of monitors connected"
            exit 1
            ;;
    esac

}
##
## Program itself just calls the functions, as simple as that
case $1 in
    "launch")
        app_launch
##        echo "This runs apps on launch"
##        exit 1
        ;;

    "swap-mode")
        swap_mode
##        echo "This swaps the computer modes"
##        exit 1
        ;;
    "startup") # THIS ARGUMENT SHOULD NOT BE USED IN i3
        swap_mode
        app_launch
##        echo "This runs both launch and swap mode"
##        exit 1
        ;;
    "polybar")
	polybar_handler "reload"
	;;
     "polybar-launch")
	polybar_handler "launch"
	;;
   *)
        echo "this breaks idiot"
        exit 1
        ;;
esac
