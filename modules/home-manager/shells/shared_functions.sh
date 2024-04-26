compress_x265() {
    mkdir -p ./compress_x265
    for video in "$@";
    do
        ffmpeg -i "$video" \
            -map 0:v:0 \
            -map 0:a? \
            -map 0:s? \
            -pix_fmt yuv420p10le \
            -c:v libx265 \
            -crf 28 \
            -preset medium \
            -c:s copy \
            -c:a libopus \
            "compress_x265/${video%.*}.mkv";
    done
    notify-send "Done" "All videos compressed"
}

compress_share() {
    for video in "$@";
    do
        ffmpeg -i "$video" \
            -map 0:v:0 \
            -map 0:a? \
            -map 0:s? \
            -c:v libx264 \
            -pix_fmt yuv420p \
            -crf 32 \
            -c:s copy \
            -c:a aac \
            "SHARE_${video%.*}.mp4"
    done
    notify-send "Done" "All videos compressed"
}

audio_to_ogg() {
    for file in "$@";
    do
        ffmpeg -i "$file" "$file.ogg"
    done
}

compress() {
    for file in "$@";
    do    
        7z a -t7z -mx=9 -mfb=273 -ms -md=31 -myx=9 -mtm=- -mmt -mmtf -md=1536m -mmf=bt3 -mmc=10000 -mpb=0 -mlc=0 "$file.7z" "$file";
        #7z a -t7z -m0=lzma2 -mx=9 -mfb=256 -md=32m -ms=on "$file.7z" "$file";
    done
    notify-send "Done" "All files compressed"
}