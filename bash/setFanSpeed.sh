#!/usr/bin/env bash

#################################################################################
#																				#
#	Set fan speed for all your attached (only AMD RX580 tested) graphics cards	#
#																				#
#	Usage:																		#
#			sudo ./setFanSpeed.sh [int speed]									#
#																				#
#	int speed is and integer ranging from 0 to 255								#
#		0 is equal to 0% fan speed												#
#		255 is equal to 100% fan speed											#
#																				#
#################################################################################

DR="/sys/class/drm"
fanSpeed=$1

if [ -z $fanSpeed ]; then
	fanSpeed="215"
fi

c=0
for i in {0..5}; do
	newDR="$DR/card$i/device/hwmon"

	if [ -d $newDR ]; then
		echo "Changing directory to $newDR/hwmon$c/"
		cd "$newDR/hwmon$c/"

		echo "Enabling PWM controll"
		sudo echo "1" > pwm1_enable

		echo "Setting fanspeed to $(( (100*fanSpeed)/255 ))%"
		sudo echo "$fanSpeed" > pwm1
		c=$(( c+1 ))
	fi
done

exit 0
