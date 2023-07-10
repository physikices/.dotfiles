#!/usr/bin/env bash

zscroll -l 30 \
	  --delay 0.3 \
    --before-text "♪ x"\
		--match-command "playerctl --player=playerctld status" \
		--match-text "playing" "--scroll 1" \
		--match-text "paused" "--before-text ' ' --scroll 0" \
		--update-check true "~/.dotfiles/polybar/modules/get_spotify_status.sh" &
wait
