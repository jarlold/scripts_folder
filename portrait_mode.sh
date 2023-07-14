#!/bin/bash

# This script lets me put my laptop with a built in stylus
# into portrait mode and back without it being weird,
# I like these Fujitsu laptops :) <3

# Run my other script that adjusts some pen settings
# and disables the touchscree
fix_stylus.sh

# Some settings that are particular to my laptop
display_name='eDP-1'
wacom_devices="11 15"


function portrait_mode() {
  # Rotate the screen to portrait
  xrandr --output $display_name --rotate right

  for device in $wacom_devices; do
    # Set the rotation to match the monitor
    xsetwacom --set $device Rotate cw
  done
}


function normal_mode() {
  # Rotate the screen to portrait
  xrandr --output $display_name --rotate normal

  for device in $wacom_devices; do
    # Set the rotation to match the monitor
    xsetwacom --set $device Rotate none
  done
}

current_orientation=$(xrandr --query --verbose | grep $display_name | cut -d ' ' -f 6)

if [ $current_orientation = 'normal' ]; then
  portrait_mode
else
  normal_mode
fi

