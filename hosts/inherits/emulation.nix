{lib, config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
      qemu libvirt virt-manager
    ];
    # groups
    users.users.jane.extraGroups = [
      "libvirtd"
    ];
    virtualisation.libvirtd.enable = true;
}
