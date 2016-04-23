#!/bin/bash
[[ -f "$HOME/consolex.env" ]] && source "$HOME/consolex.env" || \
container="$HOME/container"

while true
	do
		if [[ -f "$container/update.txt" ]]; then
			echo "Update imminent, stand by"
			touch "$container/ready.txt"
			# Saalenge ready.txt finnes
			while [[ -f "$container/ready.txt" ]]
				do
					echo Waiting for update to start..
					sleep 5
				done
			# Saalenge working.txt finnes
			while [[ -f "$container/working.txt" ]]
			do
				echo "Waiting for update to finish.."
				sleep 5
			done
			echo "Update applied, application deployed"
		else
			echo No update, re-launching..
			sleep 5
		fi
		echo "Starting deployed application"
		cd "$container/consolex"
		./consolex.sh
	done
