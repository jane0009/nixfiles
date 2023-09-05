let
  gitConfig = {
    user = "git";
    identityFile = "/run/agenix/id_gitssh";
  };
in {
  programs.ssh = {
    enable = true;

    matchBlocks = {
      # [CENSORED]
    };
  };
  # programs.git.config = gitConfig;
}
