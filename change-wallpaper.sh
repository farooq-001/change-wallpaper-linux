#!/bin/bash

# Update package lists
sudo apt update

# Install Python 3 and pip
sudo apt install python3 python3-pip -y

# Install schedule package
sudo pip install schedule

# Unzip and move wallpapers
unzip Wlp.zp.zip && rm -rf Wlp.zp.zip
sudo mkdir -p /home/change-wallpaper-linux
sudo mv Wlp /home/change-wallpaper-linux/

# Create and populate Python script
sudo tee /home/change-wallpaper-linux/change-wallpaper.py <<EOF
import os
import random
import subprocess
import schedule
import time

def change_wallpaper():
    os.environ['DISPLAY'] = ':0'
    os.environ['DBUS_SESSION_BUS_ADDRESS'] = 'unix:path=/run/user/1000/bus'  # Replace 1000 with your user ID
    WALLPAPERS_DIR = "/home/change-wallpaper-linux/Wlp"
    wallpapers = os.listdir(WALLPAPERS_DIR)
    wallpaper = random.choice(wallpapers)
    wallpaper_path = os.path.join(WALLPAPERS_DIR, wallpaper)

    # Use subprocess to call gsettings
    subprocess.run(["gsettings", "set", "org.gnome.desktop.background", "picture-uri", f"file://{wallpaper_path}"])

# Schedule the wallpaper change task to run every 1 minute
schedule.every(1).minutes.do(change_wallpaper)

# Run the scheduler in a loop
while True:
    schedule.run_pending()
    time.sleep(1)

EOF

# Create systemd service file
sudo tee /home/systemd/system/change-wallpaper.service <<EOF
[Unit]
Description=Change Wallpaper Service
After=network.target

[Service]
Environment="DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
ExecStart=/usr/bin/python3 /home/change-wallpaper-linux/change-wallpaper.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
sudo systemctl daemon-reload

# Restart and enable the service
sudo systemctl restart change-wallpaper.service
sudo systemctl enable change-wallpaper.service

# Check status
sudo systemctl status change-wallpaper.service
