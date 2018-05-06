#!/bin/bash
# Raise or lower the volume by 5%, or toggle mute. Limit volume to 150%.

function get_vol {
    pactl list sinks | grep -E "Volume.*front-left" | awk '{print $5}' | sed 's/%//'
}

function get_sink {
    pactl list sinks short | awk '{print $2}'
}

case $@ in

    "up")       if [ $(get_vol) -lt 150 ]
                then
                    pactl set-sink-volume $(get_sink) +5%
                fi
                if [ $(get_vol) -gt 150 ]
                then
                    pactl set-sink-volume $(get_sink) 150%
                fi ;;

    "down")     pactl set-sink-volume $(get_sink) -5% ;;

    "toggle")   amixer set Master toggle ;;

    *)          echo "Error. Usage: vol [up|down|toggle]"

esac

unset get_vol
unset get_sink
