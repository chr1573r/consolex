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
	reset
	header "$1"
	$1
	sleep $2
}

function screen_jmi {
	ec
	echo -e "    Incredible weather statistics from Gimlemoen"
	ec
	ec
	figlet -t -c -f mono9 " $(curl -s http://192.168.2.125/current.txt)$(echo -e "\xb0") "
	ec
	ec
	echo -e "    Provided by Jonassen meterologiske institutt"
}

function screen_terminfo {
	ec "This terminal supports $(tput lines) lines"
	ec "and $(tput cols) characters on each"
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
echo -e "Status for minecraft.csdnserver.com:"
echo
echo -e $(curl -s http://minecraft.csdnserver.com/lastupdate2.txt)
echo -e "$(curl -s http://minecraft.csdnserver.com/status2.txt)"$DEF""

}

#main, not looped
init
display "screen_jmi" "5"
display "screen_terminfo" "3"
display "screen_powerbutton" "0"
display "screen_amgstatus" "5"
