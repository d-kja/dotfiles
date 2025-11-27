#!/bin/bash

monitor="$1";
file="$2";

reference_path="$HOME/.config/hypr/assets/background-reference.gif";
output_path="$HOME/.config/hypr/assets/background.gif";

base_width="$(hyprctl monitors | grep $monitor -A1 | grep -oP '[0-9]{4}x[0-9]{4}' | awk -F'x' '{print $1}')";
base_height="$(hyprctl monitors | grep $monitor -A1 | grep -oP '[0-9]{4}x[0-9]{4}' | awk -F'x' '{print $2}')";

width="$((base_width * 2))"
height="$((base_height * 2))"

echo $width
echo $height

# Convert video (mp4) into gif
ffmpeg -i "$file" -f yuv4mpegpipe - | gifski --fps 10 -W "$width" -H "$height" -o "$reference_path" -

# Rescale based on monitor (this can take a while)
# If you want to reduce the loading time, you can use lossy or reduce the file size
gifsicle -O3 --colors=256 --resize "${base_width}x${base_height}" "$reference_path" > "$output_path"
