{
  system = "x86_64-linux";
  # modules = [
  #   "hm"
  #   "agenix"
  # ];
  modules = [
    "base"
    "secrets"
  ];
  users = ["root" "jane"];
  config = {};
}
