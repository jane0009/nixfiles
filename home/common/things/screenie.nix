{ lib, pkgs, ... }:

let
  screenshot_folder = "/home/julian/Screenshots";
  save_screenshots = false;
  elixire_token = "";

  flameshot = "${pkgs.flameshot}/bin/flameshot";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  curl = "${pkgs.curl}/bin/curl";
  jq = "${pkgs.jq}/bin/jq";
  xclip = "${pkgs.xclip}/bin/xclip";

  elixiremanager = pkgs.writeShellScriptBin "elixiremanager" ''
    response=$(
      ${curl} --compressed --connect-timeout 5 -m 120 --retry 1 \
      -H "Authorization: ${elixire_token}" -F upload=@"$1" \
      https://elixi.re/api/upload | ${jq} .url -r | tr -d '\n'
    )

    if [[ ! -z "$response" ]]; then
      echo -en "$response" | ${xclip} -selection clipboard
      ${notify-send} -t 5000 "you are now registered to use club penguin" \
        "$response" -i "$1" --hint=int:transient:1
    else
      ${notify-send} -t 5000 "error" --hint=int:transient:1
    fi
  '';

  screenie = pkgs.writeShellScriptBin "screenie" ''
    #!/usr/bin/env bash
    mkdir -p ${screenshot_folder}
    date_str=$(date +'%Y-%m-%d-%H_%M_%S')
    target="${screenshot_folder}/screenie-$date_str.png"

    ${flameshot} gui -r > "$target"

    grep "screenshot aborted" $target
    if [ $? -eq 0 ]; then
        ${notify-send} "rip"
    else
        ${notify-send} "logging into club penguin"
        ${elixiremanager}/bin/elixiremanager "$target"
        ${lib.optionalString (!save_screenshots) "rm $target"}
    fi
  '';
in { home.packages = with pkgs; [ screenie ]; }
