!#/bin/bash

echo "Killing qs instance"
killall qs
sleep 1

echo "Starting qs"
caelestia shell -d
