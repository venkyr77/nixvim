{helper, ...}: let
  inherit (helper) mkLuaBinding;
in {
  keymaps = [
    (
      mkLuaBinding "<leader>hn"
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
      mkLuaBinding "<leader>hp"
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
      mkLuaBinding "<leader>hs"
      # lua
      ''
        require("gitsigns").stage_hunk
      ''
      "[s]tage hunk"
    )
    (
      mkLuaBinding "<leader>hr"
      # lua
      ''
        require("gitsigns").reset_hunk
      ''
      "[r]eset hunk"
    )
    (
      mkLuaBinding "<leader>hu"
      # lua
      ''
        require("gitsigns").undo_stage_hunk
      ''
      "[u]ndo stage hunk"
    )
    (
      mkLuaBinding "<leader>hS"
      # lua
      ''
        require("gitsigns").stage_buffer
      ''
      "[s]tage buffer"
    )
    (
      mkLuaBinding "<leader>hR"
      # lua
      ''
        require("gitsigns").reset_buffer
      ''
      "[r]eset buffer"
    )
    (
      mkLuaBinding "<leader>hv"
      # lua
      ''
        require("gitsigns").preview_hunk
      ''
      "[v]iew hunk"
    )
    (
      mkLuaBinding "<leader>hb"
      # lua
      ''
        require("gitsigns").toggle_current_line_blame
      ''
      "[b]lame current line toggle"
    )
  ];
}
