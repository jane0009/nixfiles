{
  lib,
  opts,
  ...
}: {
  # enable docs?
  documentation = {
    enable = lib.mkForce (opts.documentation);
    nixos = {
      enable = lib.mkForce (opts.documentation);
      options.warningsAreErrors = false;
    };
    man.enable = lib.mkForce (opts.documentation);
    info.enable = lib.mkForce (opts.documentation);
    dev.enable = lib.mkForce (opts.documentation);
  };
}
