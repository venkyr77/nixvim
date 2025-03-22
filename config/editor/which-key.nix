{
  plugins.which-key = {
    enable = true;
    luaConfig.post = # lua
      ''
        require("which-key").add({
          { "<leader>f", group = "format(conform)" },
          { "<leader>h", group = "hunk(gitsigns)" },
          { "<leader>s", group = "search(telescope)" },
        })
      '';
    settings = {
      preset = "modern";
      win.border = "rounded";
    };
  };
}
