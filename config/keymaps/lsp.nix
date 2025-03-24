{helper, ...}: let
  inherit (helper) mkLuaBinding;
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
    trouble.settings.keys = {
      "<esc>" = "close";
      "/" = "close";
    };
  };
  keymaps = [
    (
      mkLuaBinding ["n"] "<leader>gd"
      # lua
      ''
        function()
          local trouble = require("trouble")
          trouble.toggle("lsp_definitions")
          trouble.fold_close_all()
        end
      ''
      "[d]efinitions"
    )
    (
      mkLuaBinding ["n"] "<leader>gD"
      # lua
      ''
        function()
          local trouble = require("trouble")
          trouble.toggle("lsp_declarations")
          trouble.fold_close_all()
        end
      ''
      "[D]eclarations"
    )
    (
      mkLuaBinding ["n"] "<leader>gi"
      # lua
      ''
        function()
          local trouble = require("trouble")
          trouble.toggle("lsp_implementations")
          trouble.fold_close_all()
        end
      ''
      "[i]mplementations"
    )
    (
      mkLuaBinding ["n"] "<leader>gr"
      # lua
      ''
        function()
          local trouble = require("trouble")
          trouble.toggle("lsp_references")
          trouble.fold_close_all()
        end
      ''
      "[r]eferences"
    )
    (
      mkLuaBinding ["n"] "<leader>gt"
      # lua
      ''
        function()
          local trouble = require("trouble")
          trouble.toggle("lsp_type_definitions")
          trouble.fold_close_all()
        end
      ''
      "[t]ype definitions"
    )
  ];
}
