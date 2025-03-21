{ pkgs, ... }:
{
  plugins = {
    lsp.servers.nixd.enable = true;
    conform-nvim.settings = with pkgs; {
      formatters.nixfmt-rfc-style.command = lib.getExe nixfmt-rfc-style;
      formatters_by_ft.nix = [ "nixfmt-rfc-style" ];
    };
  };
}
