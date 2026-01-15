!#/bin/bash

echo "Killing qs instance"
killall qs
killall quickshell
sleep 1

echo "Starting qs"
qs -c caelestia
# caelestia shell -d
