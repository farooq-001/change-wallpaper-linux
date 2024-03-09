#!/bin/bash

# Update package lists
sudo apt update

# Install Python 3 and pip
sudo apt install python3 python3-pip -y

# Install schedule package
sudo pip install schedule

sudo tar -zxvf change-wallpaper-linux.tar.gz
sudo chmod +x change-wallpaper-linux/*
sudo mv  change-wallpaper-linux /home
sudo mv  change-wallpaper-linux/change-wallpaper.service   /etc/systemd/system/change-wallpaper.service
sudo tee << .bashrc EOF
/home/change-wallpaper-linux/change-wallpaper.sh
EOF




