#!/bin/bash
# Turn off the touch screen because it's annoying
xinput set-int-prop 10 "Device Enabled" 8 0

# Make sure our scale is set to that of the monitor, and we're
# using only the laptop monitor
xsetwacom --set "11" MapToOutput eDP-1
xsetwacom --set "15" MapToOutput eDP-1

