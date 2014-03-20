#!/bin/bash

# Found this on the ArchWiki++

if [ -z $1 ]; then
  echo "Give a twitch key, squidbrain!"
  echo $0 twitch_astarast938th9th2t38th2th2
  exit 1
fi

streaming() {

#could also use
#xrandr | grep '*' | awk '{print $1}'

INRES="1920x1080" # input resolution
FPS="15" # target FPS
QUAL="fast"  # one of the many FFMPEG preset
STREAM_KEY="$1" # use the terminal command Streaming streamkeyhere to stream your video to twitch or justin
URL="rtmp://live.justin.tv/app/$STREAM_KEY" #flashver=FMLE/3.0\20(compatible;\20FMSc/1.0)"   
   #-f alsa -ac 2 -i pulse -vcodec libx264 -crf 30 -preset "$QUAL" -s "1280x720" \

ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 \
   -f alsa -ac 2 -i iec958:CARD=C920,DEV=0 -vcodec libx264 -crf 30 -preset "$QUAL" -s "1280x720" \
   -acodec libmp3lame -ab 96k -ar 44100 -threads 0 -pix_fmt yuv420p \
   -f flv "$URL"
}


streaming $1
