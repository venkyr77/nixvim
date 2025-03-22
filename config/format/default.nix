{ pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = with pkgs; {
      formatters =
        let
          denofmt = ext: {
            command = lib.getExe deno;
            args = [
              "fmt"
              "-"
              "--ext"
              ext
            ];
          };
        in
        {
          denofmt_md = denofmt "md";
          nixfmt-rfc-style.command = lib.getExe nixfmt-rfc-style;
          prettierd.command = lib.getExe prettierd;
          stylua.command = lib.getExe stylua;
        };
      formatters_by_ft = {
        markdown = [ "denofmt_md" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt-rfc-style" ];
        typescript = [ "prettierd" ];
      };
    };
  };
}
