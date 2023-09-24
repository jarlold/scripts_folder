#!/bin/bash
# Turn off the touch screen because it's annoying
touch_id=$(xsetwacom --list | grep TOUCH | grep -P --only-matching "\d{0,}")
stylus_id=$(xsetwacom --list | grep STYLUS | grep -P --only-matching "\d{0,}")
eraser_id=$(xsetwacom --list | grep ERASER | grep -P --only-matching "\d{0,}")

xinput set-int-prop ${touch_id} "Device Enabled" 8 0

# Make sure our scale is set to that of the monitor, and we're
# using only the laptop monitor
xsetwacom --set "${stylus_id}" MapToOutput eDP-1
xsetwacom --set "${eraser_id}" MapToOutput eDP-1

