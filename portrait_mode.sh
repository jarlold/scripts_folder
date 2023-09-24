#!/bin/bash

# This script lets me put my laptop with a built in stylus
# into portrait mode and back without it being weird,
# I like these Fujitsu laptops :) <3

# Run my other script that adjusts some pen settings
# and disables the touchscree
fix_stylus.sh

# Some settings that are particular to my laptop
display_name='eDP-1'

stylus_id=$(xsetwacom --list | grep STYLUS | grep -P --only-matching "\d{0,}")
eraser_id=$(xsetwacom --list | grep ERASER | grep -P --only-matching "\d{0,}")

wacom_devices="${stylus_id} ${eraser_id}"

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
  echo "Switching to portrait mode on monitors $display_name"
  portrait_mode
  fix_stylus.sh
else
  echo "Switching to normal mode on monitors $display_name"
  normal_mode
  fix_stylus.sh
  fix_stylus.sh
fi

