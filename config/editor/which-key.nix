{
  plugins.which-key = {
    enable = true;
    luaConfig.post = # lua
      ''
        require("which-key").add({
          { "<leader>h", group = "hunk(gitsigns)" },
          { "<leader>f", group = "format(conform)" },
        })
      '';
  };
}
