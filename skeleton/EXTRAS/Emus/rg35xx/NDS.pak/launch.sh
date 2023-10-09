#!/bin/sh
progdir=$(dirname "$0")/drastic
brightness=/sys/class/backlight/backlight.2/brightness
volume=/sys/class/volume/value

if [ -f "$1" ]; then
	GAME="$1"
fi

cd $progdir

cat $brightness > brightness_tmp.txt
cat volume.txt > $volume

HOME=$progdir \
ALSA_CONFIG_DIR="${progdir}/libs/alsa" \
LD_LIBRARY_PATH="${progdir}/libs" \
SDL_VIDEODRIVER=directfb \
SDL_AUDIODRIVER=alsa \
./drastic ${GAME:+"$GAME"} &> log.txt

cat $volume > volume.txt
echo 40 > $volume
cat brightness_tmp.txt > $brightness
rm brightness_tmp.txt

sync
