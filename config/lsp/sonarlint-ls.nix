{pkgs, ...}: {
  extraPackages = with pkgs; [
    sonarlint-ls
  ];

  extraPlugins = [
    {
      plugin = pkgs.vimUtils.buildVimPlugin {
        name = "sonarlint.nvim";
        src = pkgs.fetchFromGitLab {
          owner = "schrieveslaach";
          repo = "sonarlint.nvim";
          rev = "main";
          hash = "sha256-x/Z3+lF8+TaLkWOKEOdy04h9emXzP1JgX3t0EhzC4bo=";
        };
      };
    }
  ];

  plugins.lsp.postConfig = with pkgs;
  # lua
    ''
      require("sonarlint").setup({
        server = {
          cmd = {
            "${lib.getExe sonarlint-ls}",
            "-stdio",
            "-analyzers",
            vim.fn.expand("${sonarlint-ls}/share/plugins/sonarjava.jar")
          },
        },
        filetypes = { "java" },
      })
    '';
}
