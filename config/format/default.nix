{pkgs, ...}: {
  plugins.conform-nvim = {
    enable = true;
    settings = with pkgs; {
      default_format_opts.lsp_format = "fallback";
      formatters = let
        denofmt = ext: {
          command = lib.getExe deno;
          args = [
            "fmt"
            "-"
            "--ext"
            ext
          ];
        };
      in {
        alejandra.command = lib.getExe alejandra;
        denofmt_md = denofmt "md";
        nixfmt-rfc-style.command = lib.getExe nixfmt-rfc-style;
        prettierd.command = lib.getExe prettierd;
        shfmt.command = lib.getExe shfmt;
        stylua.command = lib.getExe stylua;
      };
      formatters_by_ft = {
        java.lsp_format = "prefer";
        lua = ["stylua"];
        markdown = ["denofmt_md"];
        nix = ["alejandra"];
        sh = ["shfmt"];
        typescript = ["prettierd"];
        zsh = ["shfmt"];
      };
    };
  };
}
