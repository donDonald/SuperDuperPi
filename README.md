<div align="center">
    <img src="images/license-MIT-blue.svg">
</div>


# Intro
A basic example how to turn Raspberry Pi into surveillance station.
Contains next features:
* leds - to manipulate leds, swith it on/off
* temperature - to collect temperature sensors values
* camera - to take camera shots and record videos


# Setup


## Setup environment variables
Append this to ~/.bashrc:
```
. ~/src/SuperDuperPi/.bashrc.ext
```


## Install nodejs
```
cd 3rd_part
tar -xzf node-v20.20.0-linux-armv6l.tar.gz
cd node-v20.20.0-linux-armv6l
sudo cp -R * /usr/local/
cd ..
rm -rf node-v20.20.0-linux-armv6l
```


## Install gpio WiringPi library
```
cd 3rd_party
tar xzvf WiringPi.tar.gz
cd WiringPi
./build
```


## Install camera apps
```
sudo apt install libcamera-apps
```


## Setup temperature sensors

To get drivers loaded:
```
sudo modprobe w1-gpio
sudo modprobe w1-therm
```

Make necessary modules automatically loaded.\
Edit /etc/modules
```
sudo nano /etc/modules
```
Append:
```
w1-gpio
w1-therm
```

Edit /boot/firmware/config.txt
```
sudo vim /boot/firmware/config.txt
```
Append:
```
dtoverlay=w1-gpio
```


## Perform initial setup upon system reboot
```
crontab -e
```

To perform initial setup upon reboot add this
```
@reboot ~/src/SuperDuperPi/scripts/cron_init.sh
```


# Setup periodical jobs via crontab(if needed)


### To collect temperature
```
crontab -e
```

To start a task for every 10 minutes append:
```
*/10 * * * * ~/src/SuperDuperPi/scripts/temperature/cron_values.sh
```


### To take a camera shot
```
crontab -e
```

To start a task for every 10 minutes append:
```
*/10 * * * * ~/src/SuperDuperPi/camera/cron_image.sh
```


### To take a video
```
crontab -e
```

To start a task for every 10 minutes and take 10 seconds video append:
```
*/10 * * * * ~/src/SuperDuperPi/camera/cron_video.sh 10
```
