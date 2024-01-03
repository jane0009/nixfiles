{
  pkgs,
  lib,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  pname = "hh3css";
  version = "1.0.0";
  buildInputs = [pkgs.sass];
  src = ../../cfg/hh3/sass;
  buildPhase = ''
    sass style.scss style.css
  '';
  installPhase = ''
    mkdir -p $out/css
    cp style.css.map $out/css/style.css.map
    cp style.css $out/css/style.css
  '';
}
