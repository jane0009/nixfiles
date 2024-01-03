(pkgs.vscode.override {isInsiders = true;}).overrideAttrs
(oldAttrs: rec {
  src = builtins.fetchTarball {
    url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
    sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  };
  version = "latest";

  buildInputs = oldAttrs.buildInputs ++ [pkgs.krb5];
})
