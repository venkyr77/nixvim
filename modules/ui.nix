{ inputs, ... }: {
  flake.modules.nixvim.ui = { lib, ... }: {
    plugins = {
      bufferline = {
        enable = true;
        package = inputs.self.nvimPluginPins.bufferline;
        settings.options = {
          close_command =
            lib.nixvim.mkRaw
              # lua
              ''
                function(n)
                  Snacks.bufdelete(n)
                end
              '';
          diagnostics = "nvim_lsp";
          diagnostics_indicator =
            # lua
            ''
              function(_, _, diag)
                return vim.trim(
                  (diag.error and (" " .. diag.error .. " ") or "")
                    .. (diag.warning and (" " .. diag.warning) or "")
                )
              end
            '';
          indicator.style = "underline";
          offsets = [
            {
              filetype = "neo-tree";
              highlight = "Directory";
              separator = true;
              text = "󰙅  File Explorer";
            }
          ];
        };
      };
      lualine = {
        enable = true;
        package = inputs.self.nvimPluginPins.lualine;
        settings = {
          extensions = [
            "nvim-tree"
          ];
          options = {
            component_separators = {
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
            };
            theme = "auto";
          };
          sections = {
            lualine_a = [
              {
                __unkeyed-1 = "mode";
                icons_enabled = true;
                separator = {
                  left = "▎";
                  right = "";
                };
              }
              {
                __unkeyed-1 = "";
                draw_empty = true;
                separator = {
                  left = "";
                  right = "";
                };
              }
            ];
            lualine_b = [
              {
                __unkeyed-1 = "filetype";
                colored = true;
                icon.align = "left";
                icon_only = true;
              }
              {
                __unkeyed-1 = "filename";
                separator.right = "";
                symbols = {
                  modified = " ";
                  readonly = " ";
                };
              }
              {
                __unkeyed-1 = "";
                draw_empty = true;
                separator = {
                  left = "";
                  right = "";
                };
              }
            ];
            lualine_c = [
              {
                __unkeyed-1 = "diff";
                colored = false;
                diff_color = {
                  added = "DiffAdd";
                  modified = "DiffChange";
                  removed = "DiffDelete";
                };
                separator.right = "";
                symbols = {
                  added = "+";
                  modified = "~";
                  removed = "-";
                };
              }
            ];
            lualine_x = [
              {
                __unkeyed-1.__raw =
                  # lua
                  ''
                    function()
                      local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                      if vim.tbl_isempty(clients) then
                        return "No Active LSP"
                      end
                      return vim.iter(clients):map(function(client)
                        return client.name
                      end):join(", ")
                    end
                  '';
                icon = " ";
                separator.left = "";
              }
              {
                __unkeyed-1 = "diagnostics";
                always_visible = false;
                colored = true;
                diagnostics_color = {
                  color_error.fg = "red";
                  color_info.fg = "cyan";
                  color_warn.fg = "yellow";
                };
                sources = [
                  "nvim_diagnostic"
                  "nvim_lsp"
                ];
                symbols = {
                  error = "󰅙  ";
                  hint = "󰌵 ";
                  info = "  ";
                  warn = "  ";
                };
                update_in_insert = false;
              }
            ];
            lualine_y = [
              {
                __unkeyed-1 = "";
                draw_empty = true;
                separator = {
                  left = "";
                  right = "";
                };
              }
              {
                __unkeyed-1 = "searchcount";
                maxcount = 999;
                separator.left = "";
                timeout = 120;
              }
              {
                __unkeyed-1 = "branch";
                icon = " •";
                separator.left = "";
              }
            ];
            lualine_z = [
              {
                __unkeyed-1 = "";
                draw_empty = true;
                separator = {
                  left = "";
                  right = "";
                };
              }
              {
                __unkeyed-1 = "progress";
                separator.left = "";
              }
              {
                __unkeyed-1 = "location";
              }
              {
                __unkeyed-1 = "fileformat";
                color.fg = "black";
                symbols = {
                  dos = "";
                  mac = "";
                  unix = "";
                };
              }
            ];
          };
        };
      };
      noice = {
        enable = true;
        package = inputs.self.nvimPluginPins.noice;
        settings.presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
        };
      };
      rainbow-delimiters = {
        enable = true;
        package = inputs.self.nvimPluginPins.rainbow-delimiters;
      };
    };
  };
}
