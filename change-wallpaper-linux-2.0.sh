#!/bin/bash
# set -e

# Update package lists
sudo apt update

# Install Python 3 and pip
sudo apt install python3 python3-pip -y

# Install schedule package
sudo pip install schedule

# Extract and configure change-wallpaper-linux
sudo tar -zxvf change-wallpaper-linux.tar.gz
sudo chmod +x change-wallpaper-linux/*
sudo mv change-wallpaper-linux /home
sudo mv change-wallpaper-linux/change-wallpaper.service /etc/systemd/system/change-wallpaper.service

# Add script to .bashrc for automatic execution
sudo tee -a ~/.bashrc <<EOF
/home/change-wallpaper-linux/change-wallpaper.sh
EOF

# Reload .bashrc
source ~/.bashrc

# Enable and start the service
sudo systemctl enable change-wallpaper.service
sudo systemctl start change-wallpaper.service

echo "Installation and setup completed successfully."
