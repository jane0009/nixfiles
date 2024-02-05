{lib, ...}:
with lib; {
  requires = ["base"];
  has = ["system" "home"];
  options = {
    code-server = mkOption {
      type = types.bool;
      default = false;
      description = "Enable vscode server (for remote development)";
    };
  };
}
