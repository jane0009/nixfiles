{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./gui-common.nix
  ];

  # amgdgpu 😇
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
  ];
}
