#!/bin/bash

# Create directory
sudo mkdir /home/change-wallpaper-linux

# Unzip files
sudo unzip Wlp-2.zip
sudo unzip Wlp.zip

# Create subdirectory and copy files
sudo mkdir /home/change-wallpaper-linux/Wlp
sudo cp -r Wlp/* /home/change-wallpaper-linux/Wlp/
sudo cp -r Wlp-2/* /home/change-wallpaper-linux/Wlp/

# Copy python script and systemd service file
sudo cp -r change-wallpaper.py /home/change-wallpaper-linux/Wlp
sudo cp -r change-wallpaper.service /etc/systemd/system/change-wallpaper.service

# Enable and start the systemd service
sudo systemctl enable change-wallpaper.service
sudo systemctl start change-wallpaper.service
