!#/bin/bash

echo "Killing qs instance"
killall qs
killall quickshell
sleep 1

echo "Starting qs"
caelestia shell -d
