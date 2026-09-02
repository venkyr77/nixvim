{ inputs, ... }: {
  flake.modules.nixvim.completion =
    {
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.self.modules.nixvim.snippets
      ];

      extraConfigLua =
        # lua
        ''
          vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
          })
        '';
      extraPlugins = [
        inputs.self.nvimPluginPins.lspkind
      ];
      plugins.blink-cmp = {
        enable = true;
        package = inputs.blink-cmp.packages.${pkgs.stdenv.hostPlatform.system}.default;
        settings = {
          completion = {
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 500;
            };
            list.selection = {
              auto_insert = false;
              preselect = false;
            };
            menu.draw = {
              columns = [
                {
                  __unkeyed-1 = "label";
                  __unkeyed-2 = "label_description";
                  gap = 1;
                }
                {
                  __unkeyed-1 = "kind_icon";
                  __unkeyed-2 = "kind";
                  gap = 1;
                }
                [
                  "source_name"
                ]
              ];
              components.kind_icon = {
                highlight =
                  lib.nixvim.mkRaw
                    # lua
                    ''
                      function(ctx)
                        return ctx.source_name == "Path"
                          and select(2, require("nvim-web-devicons").get_icon(ctx.label))
                          or ctx.kind_hl
                      end
                    '';
                text =
                  lib.nixvim.mkRaw
                    # lua
                    ''
                      function(ctx)
                        return (
                          ctx.source_name == "Path"
                            and (require("nvim-web-devicons").get_icon(ctx.label) or ctx.kind_icon)
                          or require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                        ) .. ctx.icon_gap
                      end
                    '';
              };
            };
          };
          keymap.preset = "enter";
          signature.enabled = true;
          snippets.preset = "luasnip";
        };
      };
    };
}
