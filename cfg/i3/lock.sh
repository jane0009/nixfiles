files=(/home/jane/Wallpapers/pony/desktop/IMG_1699.png /home/jane/Wallpapers/pony/desktop/IMG_2119.png /home/jane/Wallpapers/pony/desktop/IMG_2995.png /home/jane/Wallpapers/pony/desktop/IMG_3001.png /home/jane/Wallpapers/pony/desktop/IMG_3142.png /home/jane/Wallpapers/pony/desktop/FKzLiyWaUAITA3Z.png /home/jane/Wallpapers/pony/desktop/CBpg_02.png /home/jane/Wallpapers/pony/desktop/CBpg_05.png /home/jane/Wallpapers/pony/desktop/CBpg_06.png /home/jane/Wallpapers/pony/desktop/CBpg_08.png /home/jane/Wallpapers/pony/desktop/CBpg_16.png /home/jane/Wallpapers/pony/desktop/CBpg_19.png /home/jane/Wallpapers/pony/desktop/CBpg_20.png /home/jane/Wallpapers/pony/desktop/CBpg_28.png /home/jane/Wallpapers/pony/desktop/IMG_3221.png /home/jane/Wallpapers/pony/desktop/IMG_3342.png /home/jane/Wallpapers/pony/desktop/IMG_3367.png /home/jane/Wallpapers/pony/desktop/IMG_3442.png /home/jane/Wallpapers/pony/desktop/IMG_3463.png /home/jane/Wallpapers/pony/desktop/IMG_3600.png /home/jane/Wallpapers/pony/desktop/IMG_4939.png /home/jane/Wallpapers/pony/desktop/IMG_5055.PNG /home/jane/Wallpapers/pony/desktop/Tumblr_l_54772488713531.png /home/jane/Wallpapers/pony/desktop/FMP3yU8akAESk8Y.png /home/jane/Wallpapers/pony/desktop/Tumblr_l_114128988729378.png)
WALLPAPER=$(printf "%s\n" "${files[RANDOM % ${#files[@]}]}")
i3lock -i $WALLPAPER -t