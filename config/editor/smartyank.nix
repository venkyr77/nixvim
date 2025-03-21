{ pkgs, mkLua, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = smartyank-nvim;
      config =
        mkLua
          # lua
          ''
            require('smartyank').setup({osc52 = {ssh_only = false}})
          '';
    }
  ];
}
