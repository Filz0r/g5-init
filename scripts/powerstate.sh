#!/usr/bin/env bash

BAT=$(acpi | grep "Battery 0:")
STATE=$(echo $BAT | awk '{ if($3 =="Not") { print $3" "$4} else{ print $3} }' | sed 's/.$//')

LEVEL=$(echo $BAT | awk '{print $4}' | sed 's/.$//')

#echo $STATE
case $STATE in
	Charging)
	 	#echo "Battery is plugged and charging"
		cpupower-gui profile ondemand > /dev/null

	 	;;

	Discharging)
	 	#echo "Battery is unplugged and discharging"
	 	cpupower-gui profile powersave > /dev/null

		;;

	"Not charging")
		#echo "Battery plugged but not charging"
	 	cpupower-gui profile ondemand > /dev/null
		;;

	*)
		echo "Nothing going on here"
		;;
 esac
