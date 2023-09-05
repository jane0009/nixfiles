{
  programs.git = {
    enable = true;
    userName = "Jane Shimmer";
    userEmail = "jane@j4.pm";
    difftastic.enable = true;

    # signing = {
    #   key = "key";
    #   signByDefault = true;
    # };

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core = {
        editor = "nvim";
      };
    };
  };
}
