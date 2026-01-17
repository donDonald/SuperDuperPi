#!/bin/bash

L_PREFIX="[camera.image], "
NAME=$(date +"%Y-%m-%d_%H%M")

DESTINATION=$1
if [ -z "$DESTINATION" ]; then
    DESTINATION=$SUPERDUPERPI_DATA/camera/images/$NAME.jpg
fi


rpicam-vid --width 640 --height 480 -q 80 -o $DESTINATION
echo $L_PREFIX"destination:$DESTINATION"

# NFS setup:  http://www.instructables.com/id/Turn-Raspberry-Pi-into-a-Network-File-System-versi/
# NFS setup: https://www.htpcguides.com/configure-nfs-server-and-nfs-client-raspberry-pi/
# 1. apt install nfs-common nfs-server -y
# 2. mkdir -p ~/$SUPERDUPERPI_DATA/camera/images
# 3. add to /etc/exports
#  /home/pi/$SUPERDUPERPI_DATA 192.168.1.0/24 * (rw,sync,no_subtree_check)
# 4. sudo service rpcbind restart
# 5. sudo /etc/init.d/nfs-kernel-server restart
# 6. sudo exportfs -a
# 7 Add to /etc/rc.local
#     sudo service rpcbind restart
#     sudo /etc/init.d/nfs-kernel-server restart
#
# crontab -e
# # Hourly
# 0 * * * * /home/pi/$SPUPERDUPERPIDATA/camera/image.sh
#
# client:
# 1. apt install nfs-common -y
# 2. mkdir -p mkdir -p /mnt/data
# 3. mount 192.168.1.40:/home/pi/$SUPERDUPERPI_DATA /mnt/data
# 4. Add to /etc/fstab
#    192.168.1.40:/home/pi/$SUPERDUPERPI_DATA /mnt/data   nfs    rw  0  0

#why libcamera-still reprts like many pictures are taken
#    might seem like it is taking multiple pictures because, by default, it captures several frames to allow its automatic algorithms (Auto Exposure, Auto White Balance, Autofocus) to converge on optimal settings before the final high-resolution image is actually saved. The console output may show progress messages for each frame processed during this initial phase.
#    The application also runs a short preview phase by default (typically 5 seconds) to give these algorithms time to adjust.
#    How to ensure only one picture is taken
#    If you want libcamera-still to take only one picture without any perceived extra captures or delays, you can use the following methods:

#        Use the --immediate option: This command-line argument tells the application to skip the standard preview phase and capture the picture as soon as possible after startup.
