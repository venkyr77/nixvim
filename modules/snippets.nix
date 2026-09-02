{ inputs, ... }: {
  flake.modules.nixvim.snippets.plugins = {
    friendly-snippets = {
      enable = true;
      package = inputs.self.nvimPluginPins.friendly-snippets;
    };
    luasnip.enable = true;
  };
}
