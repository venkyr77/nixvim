{ helper, ... }:
let
  inherit (helper) mkBinding;
in
{
  keymaps = [
    (mkBinding "<leader>hn"
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
    (mkBinding "<leader>hp"
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
    (mkBinding "<leader>hs"
      # lua
      ''
        require("gitsigns").stage_hunk
      ''
      "[s]tage hunk"
    )
    (mkBinding "<leader>hr"
      # lua
      ''
        require("gitsigns").reset_hunk
      ''
      "[r]eset hunk"
    )
    (mkBinding "<leader>hu"
      # lua
      ''
        require("gitsigns").undo_stage_hunk
      ''
      "[u]ndo stage hunk"
    )
    (mkBinding "<leader>hS"
      # lua
      ''
        require("gitsigns").stage_buffer
      ''
      "[s]tage buffer"
    )
    (mkBinding "<leader>hR"
      # lua
      ''
        require("gitsigns").reset_buffer
      ''
      "[r]eset buffer"
    )
    (mkBinding "<leader>hv"
      # lua
      ''
        require("gitsigns").preview_hunk
      ''
      "[v]iew hunk"
    )
    (mkBinding "<leader>hb"
      # lua
      ''
        require("gitsigns").toggle_current_line_blame
      ''
      "[b]lame current line toggle"
    )
  ];
}
