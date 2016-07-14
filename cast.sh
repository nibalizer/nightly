#!/bin/bash

# Found this on the ArchWiki++

key=`cat ~/.twitch_key`

if [ -z $key ]; then
  echo "Give a twitch key, squidbrain!"
  echo "put key in ~/.twitch_key"
  exit 1
fi

old_streaming() {

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

 streaming() {
     INRES="1920x1080" # input resolution
     OUTRES="1920x1080" # output resolution
     FPS="15" # target FPS
     GOP="30" # i-frame interval, should be double of FPS, 
     GOPMIN="15" # min i-frame interval, should be equal to fps, 
     THREADS="2" # max 6
     CBR="1000k" # constant bitrate (should be between 1000k - 3000k)
     QUALITY="ultrafast"  # one of the many FFMPEG preset
     AUDIO_RATE="44100"
     STREAM_KEY="$1" # use the terminal command Streaming streamkeyhere to stream your video to twitch or justin
     SERVER="live-fra" # twitch server in frankfurt, see http://bashtech.net/twitch/ingest.php for list
     
     ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f alsa -i pulse -f flv -ac 2 -ar $AUDIO_RATE \
       -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p\
       -s $OUTRES -preset $QUALITY -tune film -acodec libmp3lame -threads $THREADS -strict normal \
       -bufsize $CBR output_video.mp4
#       -bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"
 }



streaming $1
