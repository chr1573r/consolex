#!/bin/bash
while true
	do
		echo "Sjekk om update er tilgjengelig"
		cd ~/container/consolex
		git remote update

		LOCAL=$(git rev-parse HEAD)
		REMOTE=$(git rev-parse @{u})

		if [ $LOCAL = $REMOTE ]; then
		    echo "Allerede nyeste versjon, ingen endring foretas"
		else
		    echo "Ny update tilgjengelig fra repo"
			echo "Send update signal til applikasjon"
			touch ~/container/update.txt

			# Saalenge ready ikke finnnes..
			while [ ! -f ~/container/ready.txt ]
			do
				echo  Venter klarering..
				sleep 10
			done
			echo "Klarering gitt!"
			echo "Naviger til rett mappe"
			cd ~/container

			echo "Melde om update in progress"
			touch working.txt

			echo "Lagre til persistence service"
			cp ~/container/watchdog1337pitft/settings.cfg ~/container/persistence/watchdog1337pitft/settings.cfg
			cp ~/container/watchdog1337pitft/hosts.lst ~/container/persistence/watchdog1337pitft/hosts.lst

			echo "Rydde opp"
			rm -rf ~/container/consolex
			rm -rf ~/container/watchdog1337pitft
			rm ~/container/update.txt
			rm ~/container/ready.txt

			echo "Klon repositories fra github"
			git clone https://github.com/chr1573r/consolex
			git clone https://github.com/chr1573r/watchdog1337pitft
			chmod -R +x ~/container/

			echo "Gjenopprett fra persistence service"
			mv  ~/container/persistence/watchdog1337pitft/settings.cfg ~/container/watchdog1337pitft/settings.cfg
			mv  ~/container/persistence/watchdog1337pitft/hosts.lst ~/container/watchdog1337pitft/hosts.lst

			echo "Melde fra om at update er ferdig"
			rm ~/container/working.txt

			echo "Skrive timestamp"
			echo "$(date)" > ~/container/last_update.txt

			echo 
			echo "Ferdig!"
		fi
		sleep 60
		echo
		echo
		echo
		echo
		echo

	done

