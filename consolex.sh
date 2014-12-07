#!/bin/bash
# Test
clear
echo "-----------------------------------------------------"
echo "| // ConsoleX //                                    |"
echo "-----------------------------------------------------"
echo "Hello World!"
echo "Last update was: $(cat ../last_update.txt)"
echo
echo "Current temperature: $(curl -s http://192.168.2.125/current.txt)"
echo
echo
echo "This terminal supports $(tput lines) lines"
echo "and $(tput cols) characters on each"
sleep 60
