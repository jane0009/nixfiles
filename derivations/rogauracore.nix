{
  pkgs,
  stdenv,
  fetchgit,
  lib,
  ...
}:
stdenv.mkDerivation {
  name = "rogauracore-1.6";
  buildInputs = with pkgs; [libusb1 autoconf automake gnumake gcc];
  src = fetchgit {
    url = "https://github.com/wroberts/rogauracore";
    rev = "a872431a59e47c1ab0b2a523e413723bdcd93a6e";
    hash = "sha256-SeG6B9ksWH4/UjLq5yPncVMTYjqMOxOh2R3N0q29fQ0=";
  };

  buildPhase = ''
    autoreconf -i
    ./configure
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp rogauracore $out/bin
  '';
}
