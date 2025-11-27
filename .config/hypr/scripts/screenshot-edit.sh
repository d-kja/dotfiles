#!/bin/bash

grim -g "$(slurp -d)" -t png - | satty --copy-command "wl-copy" --filename -

