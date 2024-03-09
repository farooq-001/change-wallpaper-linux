#!/bin/bash

# Function to compress files
compress_files() {
    # Go to the specified directory
    cd "$1" || exit
    # Loop through each file in the directory
    for file in *; do
        # Check if the file is a regular file (not a directory)
        if [ -f "$file" ]; then
            # Compress the file using tar and gzip
            tar -czvf "${file}.tar.gz" "$file"
        fi
    done
}

# Function to extract files
extract_files() {
    # Go to the specified directory
    cd "$1" || exit
    # Loop through each compressed file in the directory
    for file in *.tar.gz; do
        # Extract the file using tar
        tar -xzvf "$file" -C "$2"
    done
}

# Main script
while getopts ":c:x:" option; do
    case $option in
        c)
            # Compress files
            compress_files "$OPTARG"
            ;;
        x)
            # Extract files
            extract_files "$OPTARG" "$2"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

echo "./compress_extract.sh -c Wlp"
echo "./compress_extract.sh -x Wlp /home/change-wallpaper-linux/Wlp/"


