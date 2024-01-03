{
  pkgs,
  lib,
  ...
}:
stdenv.mkDerivation {
  name = "hh3";
  src = fetchgit {
    url = "[CENSORED]";
    deepClone = true;
  };
}
