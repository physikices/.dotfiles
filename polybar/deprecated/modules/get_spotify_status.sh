#!/usr/bin/env bash

if [ "$(playerctl --player=playerctld status)" = "Stopped" ]; then echo "No music is playing"
elif [ "$(playerctl --player=playerctld status)" = "Paused" ]; then polybar-msg -p "$(pgre -f "polybar now-playing")" hook spotify-play-pause 2 1>/dev/null 2>&
	playerctl --player=playerctld metadata --format "{{ title }} - {{ artist }}"
else polybar-msg -p "$(pgrep -f  "polybar now-playing")" hook spotify-play-pause 1 1>/dev/null 2>&
	playerctl --player=playerctld metadata --format "{{ title }} - {{ artist }}"
fi
