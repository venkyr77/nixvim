{ inputs, ... }: {
  flake.modules.nixvim.formatting =
    {
      lib,
      pkgs,
      ...
    }:
    let
      treefmtPackages = inputs.treefmt.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      plugins.conform-nvim = {
        enable = true;
        package = inputs.self.nvimPluginPins.conform-nvim;
        settings = {
          default_format_opts.lsp_format = "never";
          formatters = {
            nix-fmt = {
              args = [
                "$FILENAME"
              ];
              command = lib.getExe treefmtPackages.nix-fmt;
              stdin = false;
            };
            ruff_format.command = lib.getExe pkgs.ruff;
            rumdl = {
              args = [
                "fmt"
                "$FILENAME"
              ];
              command = lib.getExe treefmtPackages.rumdl;
              stdin = false;
            };
            shfmt = {
              args = [
                "-i"
                "2"
                "-s"
                "-filename"
                "$FILENAME"
              ];
              command = lib.getExe pkgs.shfmt;
            };
          };
          formatters_by_ft = {
            bash = [
              "shfmt"
            ];
            markdown = [
              "rumdl"
            ];
            nix = [
              "nix-fmt"
            ];
            python = [
              "ruff_format"
            ];
            sh = [
              "shfmt"
            ];
          };
        };
      };
      extraConfigLua =
        # lua
        ''
          require("which-key").add({
            { "<leader>c", desc = "+[c]onform(format)" },
            {
              "<leader>cb",
              function()
                require("conform").format()
              end,
              desc = "[b]uffer",
            },
          })
        '';
    };
}
