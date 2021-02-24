#!/bin/sh

wifi_enabled=0

for x in $(lsusb); do
	echo $x
	if [[ "$x" == *"16b4:"* ]]; then
		#USB OTG Power reset
		echo 0 > /sys/devices/dwc2_a/vbus
		sleep 1
		echo 1 > /sys/devices/dwc2_a/vbus

		result=`getprop wlan.driver.status`

		if [ "$result" == "ok" ]; then
			wifi_enabled=1
			svc wifi disable
			while [ "$result" != "unloaded" ]; do
				sleep 1
				result=`getprop wlan.driver.status`
			done
		fi

		#USB Host Power reset
		echo 126 > /sys/class/gpio/export
		echo out > /sys/class/gpio/gpio126/direction
		sleep 1
		echo 0 > /sys/class/gpio/gpio126/value
		sleep 1
		echo 1 > /sys/class/gpio/gpio126/value
		echo 126 > /sys/class/gpio/unexport

		sleep 5

		if [ "$result" == "unloaded" ] && [ $wifi_enabled -eq 1 ]; then
			svc wifi enable
		fi
	fi
done
