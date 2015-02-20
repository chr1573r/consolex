#!/bin/bash
# Test
function init {
	APPVERSION="Unstable"

	# Terminal colors
	DEF="\x1b[0m"
	WHITE="\e[0;37m"
	LIGHTBLACK="\x1b[30;01m"
	BLACK="\x1b[30;11m"
	LIGHTBLUE="\x1b[34;01m"
	BLUE="\x1b[34;11m"
	LIGHTCYAN="\x1b[36;01m"
	CYAN="\x1b[36;11m"
	LIGHTGRAY="\x1b[37;01m"
	GRAY="\x1b[37;11m"
	LIGHTGREEN="\x1b[32;01m"
	GREEN="\x1b[32;11m"
	LIGHTPURPLE="\x1b[35;01m"
	PURPLE="\x1b[35;11m"
	LIGHTRED="\x1b[31;01m"
	RED="\x1b[31;11m"
	LIGHTYELLOW="\x1b[33;01m"
	YELLOW="\x1b[33;11m"

	reset
}

function clean_up {
	reset
	clear
	echo -e "consolex.sh terminated at $(date)"
	exit
}


function ec {
	echo -e ""$1""$DEF""
}

function header {
	clear
	ec ""$LIGHTRED""$WHITE" ConsoleX $APPVERSION "$LIGHTRED"> "$LIGHTCYAN"$1"
	ec ""$LIGHTRED"-----------------------------------------------------"
	ec
}

function display {
	header "$1"
	$1
	sleep $2
}

function screen_jmi {
	ec
	echo -e "    Incredible weather statistics from Gimlemoen"
	#ec
	#ec
	figlet -t -c -f mono9 " $(curl -s http://gateway.hybel.csdnserver.com:8181/current.txt)$(echo -e "\xb0") "
	#figlet -t -c -f mono9 " $(curl -s http://okarin/current.txt)$(echo -e "\xb0") "
	#figlet -t -c -f mono9 " $(sudo temper-poll -c -q)$(echo -e "\xb0") "

	#ec
	#ec
	#echo -e "    Provided by Jonassen meterologiske institutt"
}

function screen_terminfo {
	ec "This terminal supports $(tput lines) lines"
	ec "and $(tput cols) characters on each"
	ec $(/sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')
}

function screen_powerbutton {
	echo -e "                        ###"
	echo -e "                        ###"
	echo -e "                        ###"
	echo -e "                  ###   ###   ###" 
	echo -e "                 ##     ###     ##"
	echo -e "                ##      ###      ##"
	echo -e "               ##       ###       ##"
	echo -e "               ##       ###       ##"
	echo -e "               ##                 ##"
	echo -e "                ##               ##"
	echo -e "                 ##             ##"
	echo -e "                  ####       ####"
	echo -e "                     #########"
	echo
	echo
	echo -e "         Power button, hold now to activate"
	sleep 2
	sudo python ./bin/readTouch.py
	if [[ "$?" == "0" ]]; then
		echo -ne ""$LIGHTGREEN"                  Shutdown initiated!"
		sudo halt
	fi

}

function screen_amgstatus {
echo -e ""$GREEN"                _/_/    _/      _/    _/_/_/"
echo -e "             _/    _/  _/_/  _/_/  _/       "
echo -e "            _/_/_/_/  _/  _/  _/  _/  _/_/  "
echo -e "           _/    _/  _/      _/  _/    _/   "
echo -e "          _/    _/  _/      _/    _/_/_/    "
echo
echo -e "        AutoMapGeneratorScript by Cj Designs" 
echo -e "       :------------------------------------:"$LIGHTCYAN""
echo
echo
echo
echo -e "Status for minecraft.csdnserver.com:"
echo
echo -e $(curl -s http://minecraft.csdnserver.com/lastupdate2.txt)
echo -e "$(curl -s http://minecraft.csdnserver.com/status2.txt)"$DEF""

}

function screen_mcstatus {
echo -e ""$GREEN"          CCCCCC    SSSSSS   DDDDD     NN       NN"
echo -e "        CC        SS        DD   DD   NNN      NN"
echo -e "       CC         SSS      DD    D   NN  NN   NN"
echo -e "      CC           SSS    DD    D   NN   NN  NN"
echo -e "     CC             SS   DD   DD   NN    NN NN"
echo -e "     CCCCCC   SSSSSS    DDDDD     NN     NNN"
echo -e "    _________________________________________"$LIGHTCYAN""
echo
echo -e "Minecraft server status:"
echo

while read -r HOSTENTRY; do python ./bin/mcs.py $HOSTENTRY; done < ~/container/persistent/mcs/servers.txt
echo -e ""$DEF""

}


function screen_wd1337 {
	echo "Launching fullscreen extension..."
	pushd ../watchdog1337pitft
	if [[ "$(tail -1 settings.cfg)" == "RUN_ONCE=1" ]]; then
		./watchdog1337pitft.sh
	else
		echo "RUN_ONCE=1">>settings.cfg
		./watchdog1337pitft.sh
	fi
	popd
}

#main, not looped
trap clean_up SIGINT SIGTERM
init
display "screen_jmi" "2"
display "screen_terminfo" "2"
display "screen_wd1337" "0"
#display "screen_amgstatus" "5"
#display "screen_mcstatus" "5"
display "screen_powerbutton" "0"
