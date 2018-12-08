#!/bin/sh
# Pass integer (0-255) to RPi Backlight

function rpibrightness() {
  if [ "$1" -ge 25 ] && [ "$1" -le 255 ];
    then
      sudo zsh -c "echo $1 > /sys/class/backlight/rpi_backlight/brightness" &&
      echo "Backlight adjusted to $1"
    else
      echo "For practical purposes, please choose a number between 25 and 255.";  fi
}
