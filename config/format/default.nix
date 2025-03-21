{ pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = with pkgs; {
      formatters = {
        nixfmt-rfc-style.command = lib.getExe nixfmt-rfc-style;
        prettierd.command = lib.getExe prettierd;
        stylua.command = lib.getExe stylua;
      };
      formatters_by_ft = {
        lua = [ "stylua" ];
        nix = [ "nixfmt-rfc-style" ];
        typescript = [ "prettierd" ];
      };
    };
  };
}
