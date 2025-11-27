#!/bin/bash

echo "Killing search"
pkill vicinae
sleep 1

echo "Starting server"
vicinae server

