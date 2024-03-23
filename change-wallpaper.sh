#!/bin/bash
WALLPAPERS_DIR="/home/change-wallpaper-linux/Wlp"
WALLPAPER=$(ls $WALLPAPERS_DIR | shuf -n 1)
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPERS_DIR/$WALLPAPER"
