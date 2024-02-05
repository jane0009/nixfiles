{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    qemu_full
    libvirt
    virt-manager
  ];
}
