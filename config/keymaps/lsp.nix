{helper, ...}: let
  inherit (helper) mkBinding;
in {
  plugins = {
    lsp.keymaps = {
      diagnostic = {
        "<leader>dn" = "goto_next";
        "<leader>dp" = "goto_prev";
      };
      lspBuf = {
        "<leader>lrn" = "rename";
        "<leader>lca" = "code_action";
      };
    };
    lspsaga.finder.keys = {
      quit = ["q" "<Esc>"];
      toggleOrOpen = ["o" "<CR>"];
    };
  };
  keymapsOnEvents.LspAttach = [
    (mkBinding ["n"] "<leader>gd" ":Lspsaga goto_definition<CR>" "[d]efinitions")
    (mkBinding ["n"] "<leader>gi" ":Lspsaga finder imp<CR>" "[i]mplementations")
    (mkBinding ["n"] "<leader>gr" ":Lspsaga finder ref<CR>" "[r]eferences")
    (mkBinding ["n"] "<leader>gt" ":Lspsaga finder tyd<CR>" "[t]ype definitions")
  ];
}
