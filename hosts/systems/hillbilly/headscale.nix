{
  pkgs,
  config,
  lib,
  ...
}: let
  url = "hs";
  domain = "[CENSORED]";
in {
  services.headscale = {
    enable = true;
    package = pkgs.headscale;
    address = "0.0.0.0";
    port = 443;
    settings = {
      dns_config.base_domain = "${domain}";
      server_url = "https://${url}.${domain}";
      logtail.enabled = true;
    };
  };
  environment.systemPackages = [config.services.headscale.package];
}
