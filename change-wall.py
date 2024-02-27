import os
import random
import subprocess
import schedule
import time

def change_wallpaper():
    os.environ['DISPLAY'] = ':0'
    os.environ['DBUS_SESSION_BUS_ADDRESS'] = 'unix:path=/run/user/1000/bus'  # Replace 1000 with your user ID
    WALLPAPERS_DIR = "/home/Wlp"
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
