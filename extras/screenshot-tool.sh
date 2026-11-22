#!/bin/bash


picture_name="Screenshot-$(date +%d%m%y-%H%M%S).png"

show_notification() {
	notify-send "JWM Scrot" "Screenshot saved as $picture_name"
}

fullscreen() {
	echo "Taking fullscreen screenshot"
	local file="$HOME/Pictures/Screenshots/$picture_name"
	scrot "$file" &&
		xclip -selection clipboard -t image/png -i "$file"
	show_notification
}

area_select() {
	echo "Select your area for the screenshot..."
	local file="$HOME/Pictures/Screenshots/$picture_name"
	scrot -s "$file" &&
		xclip -selection clipboard -t image/png -i "$file"
	show_notification
}

while getopts fs flag
do
	case $flag in
		f) #take a fullscreen screenshot
			fullscreen
			exit;;
		s) #let the user grab an area
			area_select
			exit;;
		\?) #invalid option!
			echo "Invalid option: -$flag."
			exit;;
	esac
done

echo "YOUR ARGUMENT -$OPTARG"
