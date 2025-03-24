{
  colorschemes.catppuccin = {
    autoLoad = true;
    enable = true;
    settings.integrations = {
      lsp_saga = true;
      noice = true;
      notify = true;
      which_key = true;
    };
  };
  plugins = {
    bufferline.settings.highlights.__raw =
      # lua
      ''
        require("catppuccin.groups.integrations.bufferline").get()
      '';
    lspsaga.ui.kind.__raw =
      # lua
      ''
        require("catppuccin.groups.integrations.lsp_saga").custom_kind()
      '';
    lualine.settings.options.theme = "catppuccin";
  };
}
