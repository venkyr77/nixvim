{
  plugins.cmp = {
    autoEnableSources = true;
    enable = true;
    settings = {
      mapping.__raw = # lua
        ''
          {
            ["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
            ["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
            ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
            ["<C-Space>"] = cmp.mapping.complete({}),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
          }
        '';
      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
    };
  };
}
