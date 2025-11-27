#!/bin/bash

echo "Killing spotify instance"
pkill spotify_player
sleep 1

echo "Creating new daemon instance"
spotify_player -d
