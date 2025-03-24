{helper, ...}: let
  inherit (helper) mkLuaBinding;
in {
  keymaps = [
    (
      mkLuaBinding ["n"] "<leader>hn"
      # lua
      ''
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "<leader>hn", bang = true })
          else
            require("gitsigns").nav_hunk("next")
          end
        end
      ''
      "[n]ext hunk"
    )
    (
      mkLuaBinding ["n"] "<leader>hp"
      # lua
      ''
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "<leader>hp", bang = true })
          else
            require("gitsigns").nav_hunk("prev")
          end
        end
      ''
      "[p]rev hunk"
    )
    (
      mkLuaBinding ["n"] "<leader>hs"
      # lua
      ''
        require("gitsigns").stage_hunk
      ''
      "[s]tage hunk"
    )
    (
      mkLuaBinding ["n"] "<leader>hr"
      # lua
      ''
        require("gitsigns").reset_hunk
      ''
      "[r]eset hunk"
    )
    (
      mkLuaBinding ["n"] "<leader>hu"
      # lua
      ''
        require("gitsigns").undo_stage_hunk
      ''
      "[u]ndo stage hunk"
    )
    (
      mkLuaBinding ["n"] "<leader>hS"
      # lua
      ''
        require("gitsigns").stage_buffer
      ''
      "[s]tage buffer"
    )
    (
      mkLuaBinding ["n"] "<leader>hR"
      # lua
      ''
        require("gitsigns").reset_buffer
      ''
      "[r]eset buffer"
    )
    (
      mkLuaBinding ["n"] "<leader>hv"
      # lua
      ''
        require("gitsigns").preview_hunk
      ''
      "[v]iew hunk"
    )
    (
      mkLuaBinding ["n"] "<leader>hb"
      # lua
      ''
        require("gitsigns").toggle_current_line_blame
      ''
      "[b]lame current line toggle"
    )
  ];
}
