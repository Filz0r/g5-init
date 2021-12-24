#!/usr/bin/env bash
## This script is a modification of how Brodie Robertson (https://github.com/Brodie Robertson)
## manipulates and changes is audio with polybar, he uses multiple small scripts that were kinda
## painfull to replicate on my setup, because my main computer is a laptop that is used
## as a desktop, so I want to be able to be in full desktop mode where I disable the laptop built in
## audio card and only use the 2 external audio sources I have connected to my laptop
##
## My setup has 2 modes:
## 1 - Desktop mode, where I have 2 outputs and 2 monitors connected to the laptop.
##     One output is used for headphones only and the other for speakers only.
## 2 - Laptop, where everything reverts back to the stock mode, enabling the built-in monitor and audio.
##
##
## This script runs the audio sources only, right now, I also use multiple scripts to configure my screens,
## eventually I'll make a replica of this script that also sets my screen layouts automatically, depending on the mode
## and finally create a "mode swapping script" that will call both these scripts, and launch everything, without having
## to run commands, or whatever when you want to launch your graphical enviroment, or just plain refresh it, on i3 I don't
## need these workarrounds, but on qtile I do, the point is to make a few scripts that will always launch your apps and set your
## configurations, without having to clutter your window manager configurations with launchers, the suckless way you might say.
## This setup will be completelly window manager agnostic, however if you want to use this setup you need change your audio sources
## and monitors accordingly, all this to say that this is only for more advanced users that know what the hell they are doing.
##
## The script runs in the following order:
## 1 - You run the script at launch of your window manager with the option "launch-audio"
## 2 - You configure the polybar hook to run the script with the option "swap-audio", to swap between outputs
## 3 - Again configure hook to run script with the option "change-volume +5%" to increase 5% of the
## volume, same for decreasing, I have this binded to the scroll wheel
## 4 - finally set an other hook with the option "mute-sink" to mute your current default sink
##
##
## DEPEDENCIES:
## (most of them are already installed if you use the GNU coreutils, so I'll only check for the essentials in the script,
## but you have the full list here for debugging.)
## - grep
## - cut
## - awk
## - echo
## - pactl
## - xrandr (since one of my outputs is binded to a monitor
##   via HDMI, the script figures out what mode you are in this way)
## - polybar & polybar-msg (Updates polybar on change)
##
##Check for depedencies before running the script
## Adaptation from the answer (https://stackoverflow.com/a/52552095) but changed from using which to command -v
for name in pactl xrandr polybar-msg
do
  [[ $(command -v $name 2>/dev/null) ]] || { echo -en "\n$name needs to be installed";deps=1; }
done
[[ $deps -ne 1 ]] || { echo -en "\nInstall the above and rerun this script\n";exit 1; }
##
## Variables
MONITORS=$(xrandr --listmonitors | grep "Monitors: " | cut -d" " -f2)
ACTIVE_SINK=$(pactl info | grep "Default Sink: " | cut -d" " -f3)
## These values require changing according to your setup
DEFAULT_CARD_ID=$(pactl list short cards | grep  "alsa_card.pci-0000_00_1f.3" | awk '{print $1}')
MONITOR_SINK="alsa_output.pci-0000_01_00.1.hdmi-stereo"
USB_DOCK_SINK="alsa_output.usb-DisplayLink_LAPDOCK_U3D2338448570-02.analog-stereo"
## Main Functions
##

change_volume() {
 pactl set-sink-volume "$ACTIVE_SINK" "$1"
 polybar-msg hook volume 1
 exit
}

swap_audio() {
 case $ACTIVE_SINK in
     "$MONITOR_SINK")
     pactl set-default-sink "$USB_DOCK_SINK"
     ;;
     "$USB_DOCK_SINK")
     pactl set-default-sink "$MONITOR_SINK"
     ;;
     *)
     echo "Invalid option, goodbye!"
     ;;
 esac
 polybar-msg hook volume 1
 exit
}

## Mutes current default sink
mute_sink() {
 pactl set-sink-mute "$ACTIVE_SINK" toggle
 polybar-msg hook volume 1
 exit
}
## Function that runs on lauch/reload of window manager
launch_swap_audio_modes() {
 case $MONITORS in
     1)
     ## Enables the builtin audio when only 1 monitor is plugged
     pactl set-card-profile "$DEFAULT_CARD_ID" on
     exit
     ;;
     2)
     ## Disables the builtin audio when 2 monitors are connected
     pactl set-card-profile "$DEFAULT_CARD_ID" off
     exit
     ;;
     *)
     ## Breaks the script, cuz errors duh
     echo "Connected monitors not configured goodbye!"
     exit 1
     ;;
 esac
}

## Case statement that figures out what function to
## call depending on the argument passed
## breaks if invalid options are passed
case $1 in
    "launch-audio")
    launch_swap_audio_modes
    ;;
    "swap-audio")
    swap_audio
    ;;
    "change-volume")
    change_volume "$2"
    ;;
    "mute-sink")
    mute_sink
    ;;
    *)
    echo "no valid options passed, goodbye!"
    exit
    ;;
esac
