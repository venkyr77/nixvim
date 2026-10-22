{ inputs, ... }: {
  flake.modules.nixvim.editor = {
    extraConfigLua =
      # lua
      ''
        require("guess-indent").setup({})
        require("smartyank").setup({ osc52 = { ssh_only = false } })
      '';
    extraPlugins = [
      inputs.self.nvimPluginPins.guess-indent
      inputs.self.nvimPluginPins.smartyank
    ];
    keymaps = [
      {
        action = "<cmd>Neotree toggle<CR>";
        key = "\\";
        options.desc = "[N]eotree [t]oggle";
      }
    ];
    plugins = {
      auto-save = {
        enable = true;
        package = inputs.self.nvimPluginPins.auto-save;
        settings.debounce_delay = 100;
      };
      gitsigns = {
        enable = true;
        package = inputs.self.nvimPluginPins.gitsigns;
        settings.on_attach =
          # lua
          ''
            function(bufnr)
              local gitsigns = require("gitsigns")
              require("which-key").add({
                { "<leader>h", buffer = bufnr, desc = "+[h]unk(gitsigns)" },
                { "<leader>ht", buffer = bufnr, desc = "+[t]oggle", icon = " " },
                { "<leader>hb", function() gitsigns.blame_line({ full = true }) end, buffer = bufnr, desc = "[b]lame line" },
                { "<leader>hn", function() gitsigns.nav_hunk("next") end, buffer = bufnr, desc = "[n]ext" },
                { "<leader>hp", function() gitsigns.nav_hunk("prev") end, buffer = bufnr, desc = "[p]rev" },
                { "<leader>hr", function() gitsigns.reset_hunk() end, buffer = bufnr, desc = "[r]eset" },
                { "<leader>hR", function() gitsigns.reset_buffer() end, buffer = bufnr, desc = "[R]eset buffer" },
                { "<leader>hs", function() gitsigns.stage_hunk() end, buffer = bufnr, desc = "[s]tage" },
                { "<leader>hS", function() gitsigns.stage_buffer() end, buffer = bufnr, desc = "[S]tage buffer" },
                { "<leader>htb", function() gitsigns.toggle_current_line_blame() end, buffer = bufnr, desc = "[b]lame" },
                { "<leader>hu", function() gitsigns.undo_stage_hunk() end, buffer = bufnr, desc = "[u]ndo stage" },
                { "<leader>hv", function() gitsigns.preview_hunk() end, buffer = bufnr, desc = "[v]iew hunk" },
              })
            end
          '';
      };
      markdown-preview = {
        enable = true;
        settings = {
          browserfunc = "mkdp#util#echo_url";
          open_ip = "127.0.0.1";
          open_to_the_world = 0;
          port = "7722";
        };
      };
      neo-tree = {
        enable = true;
        package = inputs.self.nvimPluginPins.neo-tree;
        settings = {
          clipboard.sync = "global";
          default_component_configs.indent.with_expanders = true;
          enable_cursor_hijack = true;
          enable_modified_markers = true;
          filesystem = {
            filtered_items = {
              hide_dotfiles = false;
              never_show = [
                ".git"
              ];
              visible = true;
            };
            follow_current_file = {
              enabled = true;
              leave_dirs_open = true;
            };
            group_empty_dirs = true;
            scan_mode = "deep";
            use_libuv_file_watcher = true;
          };
        };
      };
      nvim-autopairs = {
        enable = true;
        package = inputs.self.nvimPluginPins.nvim-autopairs;
      };
      render-markdown = {
        enable = true;
        package = inputs.self.nvimPluginPins.render-markdown;
      };
      todo-comments = {
        enable = true;
        package = inputs.self.nvimPluginPins.todo-comments;
      };
    };
  };
}
