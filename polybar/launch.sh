#!/usr/bin/env bash

THEME="my-theme"

# Terminate already running bar instances
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
#
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

CONFIG_DIR=$HOME/.config/polybar/themes/$THEME/config.ini
polybar main -c $CONFIG_DIR &

# Launch bar1 and bar2
# echo "---" | tee -a /tmp/polybar1.log
# polybar alg-example 2>&1 | tee -a /tmp/polybar1.log & disown
#
# echo "Bars launched..."

