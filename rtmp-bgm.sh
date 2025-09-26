#!/bin/bash

if [ -z "$RTMP_BGM" ]; then
    echo "\$RTMP_BGM is not set or is empty."
    exit
else
    echo "Streaming to: $RTMP_BGM"
fi

while true; do
    echo "Loop starting..."; echo

    for file in $(ls | grep -v .txt$ | shuf); do
        echo "Playing: $file"

        song=${file%.*}
        song=$(echo $song | sed 's/^ArtIsSound\./Art Is Sound \/ /')
        echo "🎵 $song" > $XDG_RUNTIME_DIR/current-bgm.txt

        ffmpeg -re -i "$file" -c:v copy -c:a aac -ar 48000 -f flv $RTMP_BGM

        echo; echo "Waiting for next song... (Press 'q' to quit)"
        read -t 5 -n 1 input

        if [[ $input == 'q' ]]; then
            echo "Exiting."
            exit
        fi

        echo
    done
done
