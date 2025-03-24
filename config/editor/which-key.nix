{
  plugins.which-key = {
    enable = true;
    luaConfig.post =
      # lua
      ''
        require("which-key").add({
          { "<leader>g", group = "goto(lsp)" },
          { "<leader>h", group = "hunk(gitsigns)" },
          { "<leader>l", group = "lsp" },
          { "<leader>s", group = "search(telescope)" },
        })
      '';
    settings = {
      preset = "modern";
      win.border = "rounded";
    };
  };
}
