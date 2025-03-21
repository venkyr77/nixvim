{ pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = with pkgs; {
      formatters = {
        stylua.command = lib.getExe stylua;
        nixfmt-rfc-style.command = lib.getExe nixfmt-rfc-style;
      };
      formatters_by_ft = {
        lua = [ "stylua" ];
        nix = [ "nixfmt-rfc-style" ];
      };
    };
  };
}
