{lib, config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    pkg-config
  ];
  #services.vscode-server.enable = true;
}
