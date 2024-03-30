#!/bin/bash

setup() {
    # Create directory
    sudo mkdir /home/change-wallpaper-linux

    # Unzip files
    sudo unzip Wlp.zip
    sudo unzip Wlp-2.zip
    

    # Create subdirectory and copy files
    sudo mv Wlp /home/change-wallpaper-linux/Wlp/
    sudo mv Wlp-2/* /home/change-wallpaper-linux/Wlp/

    # Copy python script and systemd service file
    sudo cp -r change-wallpaper.py   /etc/
    sudo cp -r change-wallpaper.service /etc/systemd/system/change-wallpaper.service

    # Enable and start the systemd service
    sudo systemctl enable change-wallpaper.service
    sudo systemctl start change-wallpaper.service
}

remove() {
    # Stop and disable the systemd service
    sudo systemctl stop change-wallpaper.service
    sudo systemctl disable change-wallpaper.service

    # Remove the service file
    sudo rm /etc/systemd/system/change-wallpaper.service

    # Remove the Python script and its directory
    sudo rm -rf /home/change-wallpaper-linux/Wlp/change-wallpaper.py

    # Remove the directories and their contents
    sudo rm -rf /home/change-wallpaper-linux/Wlp
    sudo rm -rf /home/change-wallpaper-linux

    # Remove the unzipped files
    sudo rm -rf Wlp-2
    sudo rm -rf Wlp
}

while true; do
    echo "Select an option:"
    echo "1. Setup"
    echo "2. Removing-Setup"
    echo "3. Exit"
    read -p "Enter your choice: " choice

    case $choice in
    1)
        setup
        ;;
    2)
        remove
        ;;
    3)
        exit 0
        ;;
    *)
        echo "Invalid option. Please select again."
        ;;
    esac
done
