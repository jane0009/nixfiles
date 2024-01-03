{
  lib,
  config,
  pkgs,
  ...
}: rec {
  users = {
    mutableUsers = false;
    users.root = {
      isSystemUser = true;
      hashedPassword = "$y$j9T$t1bGVNSEvMzy2UmZnGx6H/$SNX.jC4.EP87eYAXwfXlC1pcs1KCWFTpUWY30axVSv7";
    };
  };
}
