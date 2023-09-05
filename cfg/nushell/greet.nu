export def greet [] {
    let greet_color = (ansi cyan_bold)

    let greet_message = (fortune -e /home/jane/.config/nushell/petoria-2022-02.fortune)
    let joined_greet = (['"', $greet_color, $greet_message, '"'] | str join)
    let ponysay_msg = (ponysay --anypony sunset_shimmer --anypony luna --anypony twilight --anypony twilightrage --anypony twilightprincess --anypony heartstrings --anypony trixie --anypony trixiestand --anypony pinkie --anypony pinkiebounce --anypony pinkiecannon --anypony pinkiefly --anypony fluttershy --anypony fluttershybat --anypony twilacorn $joined_greet)
    let neofetch_msg = (neofetch --config ~/.config/neofetch/config --stdout --disable kernel shell de wm term resolution cpu gpu host distro)
    ([$ponysay_msg, "\n", $neofetch_msg] | str join)
}

greet
