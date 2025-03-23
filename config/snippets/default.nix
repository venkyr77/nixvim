{
  plugins = {
    cmp.settings = {
      snippet.expand =
        # lua
        ''
          function(args)
            require("luasnip").lsp_expand(args.body)
          end
        '';
      sources = [{name = "luasnip";}];
    };
    cmp_luasnip.enable = true;
    friendly-snippets.enable = true;
    luasnip.enable = true;
  };
}
