{
  plugins.lsp = {
    enable = true;
    postConfig = # lua
      ''
        require("lspconfig").bashls.setup({
            handlers = {
              ["textDocument/publishDiagnostics"] = function() end,
            },
        })
      '';
    servers = {
      bashls = {
        enable = true;
        filetypes = [
          "sh"
          "zsh"
        ];
      };
      lua_ls.enable = true;
      marksman.enable = true;
      nixd.enable = true;
      ts_ls.enable = true;
    };
  };
}
