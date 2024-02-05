let
  gitConfig = {
    user = "git";
    identityFile = "/run/agenix/id_gitssh";
  };
in {
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github.com" = gitConfig;
      "gitlab.com" = gitConfig;
      "ssh.gitdab.com" = gitConfig;
      "git.j4.pm" = gitConfig;
      "git.coolmathgames.tech" = gitConfig;
    };
  };
  # programs.git.config = gitConfig;
}
