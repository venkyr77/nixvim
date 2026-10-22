{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nixvim.flakeModules.auto
    inputs.nixvim.flakeModules.nixvimConfigurations
  ];

  config = {
    flake = {
      modules.nixvim.default = { pkgs, ... }: {
        imports = [
          inputs.self.modules.nixvim.completion
          inputs.self.modules.nixvim.debugging
          inputs.self.modules.nixvim.diagnostic
          inputs.self.modules.nixvim.editor
          inputs.self.modules.nixvim.formatting
          inputs.self.modules.nixvim.lint
          inputs.self.modules.nixvim.lsp
          inputs.self.modules.nixvim.ui
        ];

        colorschemes.catppuccin = {
          enable = true;
          package = inputs.self.nvimPluginPins.catppuccin;
          settings = {
            auto_integrations = false;
            custom_highlights =
              # lua
              ''
                function(colors)
                  return {
                    RainbowBlue = { blend = 0, fg = colors.blue },
                    RainbowCyan = { blend = 0, fg = colors.teal },
                    RainbowGreen = { blend = 0, fg = colors.green },
                    RainbowOrange = { blend = 0, fg = colors.peach },
                    RainbowRed = { blend = 0, fg = colors.red },
                    RainbowViolet = { blend = 0, fg = colors.mauve },
                    RainbowYellow = { blend = 0, fg = colors.yellow },
                  }
                end
              '';
            default_integrations = false;
            flavour = "mocha";
            integrations = {
              blink_cmp = {
                enabled = true;
                style = "bordered";
              };
              gitsigns = true;
              neotree = true;
              noice = true;
              rainbow_delimiters = true;
              render_markdown = true;
              snacks = true;
              which_key = true;
            };
          };
        };
        extraConfigLua =
          # lua
          ''
            require("which-key").add({
              { "<leader>f", desc = "+[f]ind(snacks)", icon = " " },
              {
                "<leader>ff",
                function()
                  Snacks.picker.files()
                end,
                desc = "[f]iles",
              },
              {
                "<leader>fg",
                function()
                  Snacks.picker.grep()
                end,
                desc = "[g]rep",
              },
            })
          '';
        extraPackages = [
          pkgs.fd
          pkgs.ripgrep
        ];
        extraPlugins = [
          inputs.self.nvimPluginPins.plenary
        ];
        globals = {
          mapleader = " ";
          maplocalleader = " ";
        };
        keymaps = [
          {
            action = "<cmd>nohlsearch<CR>";
            key = "<Esc>";
            mode = "n";
          }
        ];
        nixpkgs.source = inputs.nixpkgs;
        opts = {
          cursorline = true;
          laststatus = 3;
          number = true;
          relativenumber = true;
          signcolumn = "yes";
          splitbelow = true;
          splitright = true;
          termguicolors = true;
          undofile = true;
        };
        plugins = {
          nui = {
            enable = true;
            package = inputs.self.nvimPluginPins.nui;
          };
          snacks = {
            enable = true;
            package = inputs.self.nvimPluginPins.snacks;
            settings = {
              indent = {
                enabled = true;
                indent.hl = [
                  "RainbowBlue"
                  "RainbowCyan"
                  "RainbowGreen"
                  "RainbowOrange"
                  "RainbowRed"
                  "RainbowViolet"
                  "RainbowYellow"
                ];
                scope.enabled = false;
              };
              notifier.enabled = true;
              picker = {
                enabled = true;
                sources = {
                  files.layout.fullscreen = true;
                  grep.layout.fullscreen = true;
                };
                ui_select = true;
              };
              scroll.enabled = true;
              words.enabled = true;
            };
          };
          treesitter = {
            enable = true;
            highlight.enable = true;
            indent.enable = true;
          };
          web-devicons = {
            enable = true;
            package = inputs.self.nvimPluginPins.web-devicons;
          };
          which-key = {
            enable = true;
            package = inputs.self.nvimPluginPins.which-key;
            settings.preset = "modern";
          };
        };
      };
      nvimPluginPins =
        (import ../npins { })
        |> builtins.mapAttrs (
          _: pin:
          pin
          // {
            passthru = { };
            pname = pin.repository.repo;
            version = pin.revision;
          }
        );
    };
    nixvim.packages.enable = true;
    perSystem = { system, ... }: {
      nixvimConfigurations.default = inputs.nixvim.lib.evalNixvim {
        modules = [
          config.flake.modules.nixvim.default
        ];
        inherit system;
      };
    };
  };
  options.flake.nvimPluginPins = lib.mkOption {
    description = "Neovim plugin sources pinned by npins";
    readOnly = true;
    type = lib.types.attrsOf lib.types.unspecified;
  };
}
