#!/bin/bash
# Test
clear
echo "ConsoleX"
echo
echo "Hello World!"
echo -n "Last update was: $(cat ../last_update.txt)"
echo
echo "This terminal supports $(tput lines) lines"
echo "and $(tput cols) characters on each"
sleep 60
