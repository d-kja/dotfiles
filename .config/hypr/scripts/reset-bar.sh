!#/bin/bash

echo "Killing waybar instance"
pkill waybar
sleep 1

echo "Starting waybar"
waybar &
