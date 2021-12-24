#!/usr/bin/bash

# Switching between keyboard layouts
CURRENT_LAYOUT=$(setxkbmap -query | awk 'NR==3{print $2}')

case "$CURRENT_LAYOUT" in
	"au")
		setxkbmap -layout "pt"
		;;
	"pt")
		setxkbmap -layout "au"
		;;
    "*")
        echo "Dum dum you're wrong"
        ;;
esac
