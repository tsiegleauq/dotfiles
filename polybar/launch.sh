#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bars
#polybar workspaces
#polybar music
#polybar status
polybar main &

echo "Bars launched..."
