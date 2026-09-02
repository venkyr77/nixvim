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
          inputs.self.modules.nixvim.diagnostic
          inputs.self.modules.nixvim.editor
          inputs.self.modules.nixvim.formatting
          inputs.self.modules.nixvim.lint
          inputs.self.modules.nixvim.lsp
          inputs.self.modules.nixvim.ui
        ];

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
              { "<leader>t", desc = "+[t]heme", icon = " " },
              {
                "<leader>tt",
                function()
                  vim.o.background = vim.o.background == "dark" and "light" or "dark"
                  vim.cmd.colorscheme("everforest")
                end,
                desc = "[t]oggle dark/light",
              },
            })
          '';
        extraConfigLuaPre =
          # lua
          ''
            require("everforest").setup({
              background = "hard",
              on_highlights = function(highlights, palette)
                highlights.DiagnosticUnderlineHint = {
                  sp = palette.purple,
                  undercurl = true,
                }
              end,
            })
            vim.cmd.colorscheme("everforest")
          '';
        extraPackages = [
          pkgs.fd
          pkgs.ripgrep
        ];
        extraPlugins = [
          inputs.self.nvimPluginPins.everforest
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
                  "RainbowDelimiterBlue"
                  "RainbowDelimiterCyan"
                  "RainbowDelimiterGreen"
                  "RainbowDelimiterOrange"
                  "RainbowDelimiterRed"
                  "RainbowDelimiterViolet"
                  "RainbowDelimiterYellow"
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
