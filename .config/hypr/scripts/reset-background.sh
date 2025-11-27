#!/bin/bash

echo "Killing daemon"
awww kill 

echo "Cleaning cache"
awww clear-cache
sleep 1

echo "Running daemon"
awww-daemon &
sleep 1

pattern="background\..*"
file="$(ls "$HOME/.config/hypr/assets" | grep $pattern)"

echo "Setting up background GIF"
awww img "$HOME/.config/hypr/assets/$file" --transition-type simple
