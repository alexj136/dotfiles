#!/bin/sh
xrandr | grep -oE "current [[:digit:]]+" | sed -e "s/current //" | tr -d '\n'
