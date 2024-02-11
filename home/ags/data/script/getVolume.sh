#!/usr/bin/env bash

VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tr -d '.' | grep -Po "\\d+" | sed 's/^0*\(.*\)/\1/')
MUTE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep [MUTED])


if [ -z "$MUTE" ];
then
    :
else
    echo "-1"
    exit
fi

if [ -z "$VOL" ];
then
    echo 0
    exit
else
    echo $VOL
    exit
fi
