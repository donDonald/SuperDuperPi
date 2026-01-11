#!/bin/bash

L_PREFIX="[camera.video] "
INTEGER='^[0-9]+$'
NAME=$(date +"%Y-%m-%d_%H%M")

if [ -z $1 ]; then
    echo $L_PREFIX"Duration is not set"
    echo $L_PREFIX"Usage: video.sh <duration(seconds)> [segment(seconds)] [destination]"
    exit 1
fi
DURATION=$1
if ! [[ $DURATION =~ $INTEGER ]] ; then
    echo $L_PREFIX"Incorrect duration"
fi
DURATION=$(($DURATION * 1000))

if [ ! -z $2 ]; then
    if [[ $2 =~ $INTEGER ]] ; then
        # it's segemt
        SEGMENT=$2
        SEGMENT=$(($SEGMENT * 1000))
    else
        # it's output
        DST=$2
    fi
fi

if [ -z "$DST" ]; then
    DST=$3
    if [ -z "$DST" ]; then
        DST=$SUPERDUPERPI_DATA/camera/videos/$NAME.mp4
    fi
fi

if [ -z $SEGMENT ]; then
    rpicam-vid --width 640 --height 480 -t $DURATION -o $DST
else
    rpicam-vid --width 640 --height 480 -t $DURATION --segment $SEGMENT --inline -o $DST
fi

echo $L_PREFIX"Video is saved to $DST"

# raspivid
# https://raspberrypi.stackexchange.com/questions/27082/how-to-stream-raspivid-to-linux-and-osx-using-gstreamer-vlc-or-netcat {
#     Client {
#         sudo apt install mplayer
#         nc -l 2222 | mplayer -fps 200 -demuxer h264es -
#     }
#
#     pi {
#         /opt/vc/bin/raspivid -t 0 -w 300 -h 300 -hf -fps 20 -o - | nc <IP-OF-THE-CLIENT> 2222
#     }
#
#    Conclusion {
#        Works {
#            $ raspivid -v
#            raspivid Camera App v1.3.12
#            $ uname -a
#            Linux raspberrypi 4.4.50+ #970 Mon Feb 20 19:12:50 GMT 2017 armv6l GNU/Linux
#        }
#    }
# }
#
# Motion {
#     https://habrahabr.ru/post/125216/
#     https://habrahabr.ru/post/72491/
#     https://habrahabr.ru/post/190728/
#
#     sudo apt-get update
#     sudo apt-cache show motion
# }
#
# Info {
#     https://www.linux.org.ru/forum/general/13061585 
# }
