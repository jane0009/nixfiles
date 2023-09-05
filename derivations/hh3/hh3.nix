{ pkgs, lib, ... }:
let

in
stdenv.mkDerivation {
  
}
# (pkgs.discord-ptb.overrideAttrs (old: {
#   postInstall = old.postInstall + ''
#     mv $out/opt/DiscordPTB/resources/app.asar $out/opt/DiscordPTB/resources/_app.asar
#     mkdir -p $out/opt/DiscordPTB/resources/app/app_bootstrap
#     cat > $out/opt/DiscordPTB/resources/app/app_bootstrap/index.js <<- EOF
#     const path = require("path")
#     require(path.resolve(process.env.HOME, ".local/share/hhgregg/lib/injector.js"))
#       .inject(path.resolve(__dirname, "../../../_app.asar"))
#     require("../../_app.asar")
#     process.mainModule = require.cache[require.resolve("../../_app.asar")]
#     EOF
#     cat > $out/opt/DiscordPTB/resources/app/package.json <<- EOF
#     { "name": "discord", "main": "./app_bootstrap/index.js", "private": true }
#     EOF
#   '';
# }))