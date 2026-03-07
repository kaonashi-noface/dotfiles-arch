#!/bin/bash

# Require video filename to convert to png
# TODO: add optional flags to add ffmpeg timestamp
if [ $# -ne 1 ]; then
    echo "Error: Please input exactly one argument for the video filename."
    echo "Usage: $0 <video_file_name>"
    exit -1
fi

input=$1

# Currently only supporting Silent SDDM video formats
# Originally was going to pipe ffmpeg -codecs output 
# into a hash but videography terminology/ world is
# complicated.
declare -A ffmpeg_ext_hash=(
    [".webm"]=1	
    [".mp4"]=1
    [".mov"]=1
    [".mkv"]=1
    [".avi"]=1
    [".m4v"]=1
)

filename=""
file_ext=""
is_valid_ext=0
for ext in "${!ffmpeg_ext_hash[@]}"; do
    regex="^([^.]*)\\${ext}(\\.[^.]*)?\$"
    if [[ "${input}" =~ $regex ]]; then
        filename="${BASH_REMATCH[1]}"
        file_ext="${ext}"
        is_valid_ext=1
        break
    fi
done

if [ $is_valid_ext -eq 0 ]; then
    echo "Error: ${input} - invalid extension"
    exit -2
fi

# hardcoded to get the first frame
ffmpeg -ss "00:00:00" -i "${filename}${file_ext}" -frames:v 1 -update 1 -c:v png "${filename}.png"

