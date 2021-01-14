#!/bin/sh
if [ -e "/internal/boot.ini" ]
then
    break
else
    cp /system/etc/boot.ini.template /internal/boot.ini
fi

if [ -e "/internal/Image" ]
then
    break
else
    cp /system/etc/Image /internal/Image
fi

if [ -e "/internal/default.prop" ]
then
    break
else
    cp /system/etc/default.prop.template /internal/default.prop
fi

if [ -e "/internal/usb_modeswitch.conf" ]
then
    break
else
    cp /system/etc/usb_modeswitch.conf.template /internal/usb_modeswitch.conf
fi
