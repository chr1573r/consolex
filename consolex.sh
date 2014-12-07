#!/bin/bash
# Test
clear
echo "---------------------------------------------------"
echo " /// ConsoleX ///                                 |"
echo "---------------------------------------------------"
echo "Hello World!"
echo "Last update was: $(cat ../last_update.txt)"
echo
echo "This terminal supports $(tput lines) lines"
echo "and $(tput cols) characters on each"
sleep 60
