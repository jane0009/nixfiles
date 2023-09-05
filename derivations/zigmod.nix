{pkgs
, stdenv
, callPackage
, fetchFromGitHub
, cacert
, git
, zig
, lib
, ...}:
let
  pname = "zigmod";
  version = "88";

  src = fetchFromGitHub {
    owner = "nektro";
    repo = "zigmod";
    rev = "r${version}";
    hash = "sha256-nhTpPhqPB9ZreAQePzHZAip7rwAF7o8nhd+rOtQ8yn0=";
  };

  preBuild = ''
    export XDG_CACHE_HOME="$(mktemp -d)"
  '';

  depsDir = "zig-cache/zigmod";

  deps = stdenv.mkDerivation {
    name = "${pname}-deps.tar.gz";

    inherit pname preBuild src version;

    nativeBuildInputs = [
      cacert
      git
      zig
    ];

    buildPhase = ''
      runHook preBuild

      # Dependencies will be fetched prior to building this dummy program
      echo "pub fn main() void {}" > src/main.zig
      zig build
    '';

    installPhase = ''
      find ${depsDir} -name .git -type d -prune -exec rm -rf {} \;;
      # Build a reproducible tar, per instructions at https://reproducible-builds.org/docs/archives/
      tar --owner=0 --group=0 --numeric-owner --format=gnu \
          --sort=name --mtime="@$SOURCE_DATE_EPOCH" \
          -czf $out -C ${depsDir} .
    '';

    outputHash = "sha256-pVj8pWPLbLHg6UEpHv/Jz6KhPBXJbggWJwNySB7a6KY=";
  };
in
stdenv.mkDerivation {
  inherit pname version src preBuild;

  nativeBuildInputs = [
    zig
  ];

  postUnpack = ''
    mkdir -p $sourceRoot/${depsDir}
    tar -xf ${deps} -C $sourceRoot/${depsDir}
  '';

  buildPhase = ''
    runHook preBuild

    zig build -Dmode=ReleaseSafe -Dcpu=baseline -Dtag=${version} --prefix $out

    runHook postBuild
  '';

  passthru.tests = callPackage ./tests { };

  meta = {
    description = "A package manager for the Zig programming language";
    homepage = "https://github.com/nektro/zigmod";
    changelog = "https://github.com/nektro/zigmod/releases/tag/r${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ paveloom ];
    inherit (zig.meta) platforms;
  };
}