{ inputs, ... }: {
  flake.modules.nixvim.lsp = { lib, pkgs, ... }: {
    lsp = {
      onAttach =
        # lua
        ''
          if vim.b[bufnr].nixvim_lsp_keymaps_registered then
            return
          end
          vim.b[bufnr].nixvim_lsp_keymaps_registered = true
          local picker_opts = {
            layout = { fullscreen = true },
          }
          require("which-key").add({
            {
              "<leader>g",
              buffer = bufnr,
              desc = "+[g]oto(lsp)",
              icon = " ",
            },
            {
              "<leader>gD",
              function()
                Snacks.picker.lsp_declarations(picker_opts)
              end,
              buffer = bufnr,
              desc = "[D]eclarations",
            },
            {
              "<leader>gd",
              function()
                Snacks.picker.lsp_definitions(picker_opts)
              end,
              buffer = bufnr,
              desc = "[d]efinitions",
            },
            {
              "<leader>gi",
              function()
                Snacks.picker.lsp_implementations(picker_opts)
              end,
              buffer = bufnr,
              desc = "[i]mplementations",
            },
            {
              "<leader>gr",
              function()
                Snacks.picker.lsp_references(picker_opts)
              end,
              buffer = bufnr,
              desc = "[r]eferences",
            },
            {
              "<leader>gt",
              function()
                Snacks.picker.lsp_type_definitions(picker_opts)
              end,
              buffer = bufnr,
              desc = "[t]ype definitions",
            },
            {
              "<leader>l",
              buffer = bufnr,
              desc = "+[l]sp",
            },
            {
              "<leader>la",
              function()
                vim.lsp.buf.code_action()
              end,
              buffer = bufnr,
              desc = "code [a]ction",
            },
            {
              "<leader>lr",
              function()
                vim.lsp.buf.rename()
              end,
              buffer = bufnr,
              desc = "[r]ename",
            },
          })
        '';
      servers = {
        bashls = {
          enable = true;
          config.settings.bashIde = {
            shellcheckPath = lib.getExe pkgs.shellcheck;
            shfmt.path = lib.getExe pkgs.shfmt;
          };
        };
        basedpyright = {
          enable = true;
          config.settings.basedpyright.analysis.typeCheckingMode = "recommended";
        };
        marksman.enable = true;
        nixd.enable = true;
        rumdl = {
          enable = true;
          package = inputs.treefmt.packages.${pkgs.stdenv.hostPlatform.system}.rumdl;
        };
        vtsls.enable = true;
      };
    };
    plugins = {
      jdtls = {
        enable = true;
        jdtLanguageServerPackage = null;
        settings.settings.java = {
          completion.enabled = true;
          configuration.runtimes = [
            {
              name = "JavaSE-1.8";
              path = pkgs.jdk8.home;
            }
            {
              name = "JavaSE-11";
              path = pkgs.jdk11.home;
            }
            {
              default = true;
              name = "JavaSE-17";
              path = pkgs.jdk17.home;
            }
            {
              name = "JavaSE-21";
              path = pkgs.jdk21.home;
            }
            {
              name = "JavaSE-25";
              path = pkgs.jdk25.home;
            }
          ];
          contentProvider.preferred = "fernflower";
          eclipse.downloadSources = true;
          inlayHints.parameterNames.enabled = "all";
          signatureHelp.enabled = true;
          sources.organizeImports = {
            starThreshold = 9999;
            staticStarThreshold = 9999;
          };
        };
      };
      lspconfig.enable = true;
    };
  };
}
