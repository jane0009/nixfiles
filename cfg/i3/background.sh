#!/usr/bin/env /run/current-system/sw/bin/bash

set_wallpaper  () {
	files=(/home/jane/Wallpapers/pony/desktop/* /home/jane/Wallpapers/game/* /home/jane/Wallpapers/homestuck/*)
	WALLPAPER=$(printf "%s\n" "${files[RANDOM % ${#files[@]}]}")
	WALLPAPER2=$(printf "%s\n" "${files[RANDOM % ${#files[@]}]}")
	/run/current-system/sw/bin/feh -B white --bg-fill $WALLPAPER --bg-fill $WALLPAPER2
}

# every hour (60*60 seconds)
while true; do
	set_wallpaper
	sleep 3600
done
#watch -n 3600 set_wallpaper
