{
  # add in hyprland :D
  # modules = ["hm" "agenix" "hyprland"];
  modules = [
    "gui"
    "remote"
    "secrets"
    "tailscale"
    "bluetooth"
    "dev"
    "gaming"
    "emulation"
    "power"
  ];
  config = {
    ssd = true;
    gpu = "nvidia";
    wm = "wayland";
  };
}
