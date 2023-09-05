{ pkgs }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ gruvbox-nvim ];
    extraConfig = ''
      colorscheme gruvbox
      set noswapfile
      set scrolloff=5
    '';
    #extraLuaConfig = ''
    #  require("lualine").setup({ options = { theme = require("lualine.themes.gruvbox") } })
    #'';
  };
}
