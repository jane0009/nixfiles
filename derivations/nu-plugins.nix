# required for a number of plugins. because. ???
{pkgs, lib, rustPlatform, ...}:
let
    nushell-src = pkgs.fetchFromGitHub {
        name = "nushell";
        version = "0.87.1";
        owner = "nushell";
        repo = "nushell";
        rev = "0.87.1";
        hash = "sha256-lPfP0bnMTb+IQoWdf7oHaj96/l68Ic6OmB/Ur9Q65g8=";
    };
    git-repos = [
        {
            owner = "fdncred";
            repo = "nu_plugin_file";
            rev = "ccde56d1341cdbef88c4f5c128dc596ecbf4f323";
            hash = "sha256-eUK/S3jTRsXlB/mNtqt6d7br9UFS+pDf3jcfXbUKd+8=";
            target = "target/release/nu_plugin_file";
        }
        # {
        #    owner = "tesujimath";
        #    repo = "nu_plugin_bash_env";
        #    rev = "ea66371083e6f9515d223b2dd46102db87bc92d4";
        #    hash = "sha256-lU+hEGHva+wJ/dVKoYWbaWZhssdi0a+qX6iScShoQQ4=";
        # }
        {
            owner = "fdncred";
            repo = "nu_plugin_emoji";
            rev = "85b4125de920ecb62eda4e97752a6bc887923f9";
            hash = "sha256-vNK4D+JJXJEB+wvzlhZPkbRJN6Zu3O/GQOqYTKah6EQ=";
            target = "target/release/nu_plugin_emoji";
        }
        {
            owner = "cptpiepmatz";
            repo = "nu-plugin-highlight";
            rev = "74997784297325b5a896d1fa430a8c6b8d7d5f5f";
            hash = "sha256-mOmVOPBWENCloA9HcORVSm/dAv6OT/EsIJZ2xVA6MhI=";
            target = "target/release/nu_plugin_highlight";
            replace = "--replace 0.86 0.87.1";
        }
    ];
in
lib.lists.forEach git-repos (x: rustPlatform.buildRustPackage rec {
pname = x.repo;
version = x.rev;
nativeBuildInputs = [ pkgs.clang pkgs.rustc pkgs.nushell ];
nushellSrc = nushell-src;
installTarget = x.target;
customReplace = x.replace or "";
src = pkgs.fetchFromGitHub {
    owner = x.owner;
    repo = x.repo;
    rev = x.rev;
    hash = x.hash;
};
dontBuild = false; # verify the substitution
buildPhase = ''
    substituteInPlace Cargo.toml \
        --replace ../nushell $nushellSrc $customReplace
    cargo install --path .
'';
installPhase = ''
    mkdir -p $out/bin
    # mkdir -p $out/fullSource
    # cp -r * $out/fullSource
    cp $installTarget $out/bin
'';
})