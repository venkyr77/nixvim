{
  plugins.lualine = {
    enable = true;
    settings = {
      extensions = [ "neo-tree" ];
      sections = {
        lualine_a.__raw = # lua
          ''
            {
              {
                "mode",
                icons_enabled = true,
                separator = { left = "▎", right = "" },
              },
              {
                "",
                draw_empty = true,
                separator = { left = "", right = "" },
              },
            }
          '';
        lualine_b.__raw = # lua
          ''
            {
              {
                "filetype",
                colored = true,
                icon_only = true,
                icon = { align = "left" },
              },
              {
                "filename",
                symbols = { modified = " ", readonly = " " },
                separator = { right = "" },
              },
              {
                "",
                draw_empty = true,
                separator = { left = "", right = "" },
              },
            }
          '';
        lualine_c.__raw = # lua
          ''
            {
              {
                "diff",
                colored = false,
                diff_color = {
                  added = "DiffAdd",
                  modified = "DiffChange",
                  removed = "DiffDelete",
                },
                symbols = { added = "+", modified = "~", removed = "-" },
                separator = { right = "" },
              },
            }
          '';
        lualine_x.__raw = # lua
          ''
            {
              {
                function()
                  local buf_ft = vim.api.nvim_get_option_value("filetype", {})

                  local excluded_buf_ft = { "neo-tree", "TelescopePrompt" }

                  for _, excluded_type in ipairs(excluded_buf_ft) do
                    if buf_ft == excluded_type then
                      return ""
                    end
                  end

                  local clients = vim.lsp.get_active_clients()
                  local msg = "No Active Lsp"

                  if next(clients) == nil then
                    return msg
                  end

                  for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                      return client.name
                    end
                  end

                  return msg
                end,
                icon = " ",
                separator = { left = "" },
              },
              {
                "diagnostics",
                sources = { "nvim_lsp", "nvim_diagnostic" },
                symbols = { error = "󰅙  ", warn = "  ", info = "  ", hint = "󰌵 " },
                colored = true,
                update_in_insert = false,
                always_visible = false,
                diagnostics_color = {
                  color_error = { fg = "red" },
                  color_warn = { fg = "yellow" },
                  color_info = { fg = "cyan" },
                },
              },
            }
          '';
        lualine_y.__raw = # lua
          ''
            {
              {
                "",
                draw_empty = true,
                separator = { left = "", right = "" },
              },
              {
                "searchcount",
                maxcount = 999,
                timeout = 120,
                separator = { left = "" },
              },
              {
                "branch",
                icon = " •",
                separator = { left = "" },
              },
            }
          '';
        lualine_z.__raw = # lua
          ''
            {
              {
                "",
                draw_empty = true,
                separator = { left = "", right = "" },
              },
              {
                "progress",
                separator = { left = "" },
              },
              { "location" },
              {
                "fileformat",
                color = { fg = "black" },
                symbols = {
                  unix = "",
                  dos = "",
                  mac = "",
                },
              },
            }
          '';
      };
    };
  };
}
