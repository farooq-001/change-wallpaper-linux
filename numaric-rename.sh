#!/bin/bash

# Go to the specified directory
cd /home/farooq/Desktop/Wlp/ || exit

# Counter for renaming
count=1

# Loop through each file in the directory
for file in *; do
    # Check if the file is a regular file (not a directory)
    if [ -f "$file" ]; then
        # Rename the file with a numeric name
        mv "$file" "${count}.jpg"  # Assuming the files are JPEG images, change the extension if needed
        count=$((count + 1))
    fi
done

