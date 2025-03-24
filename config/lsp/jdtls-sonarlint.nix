{pkgs, ...}: {
  extraPackages = with pkgs; [
    lombok
  ];

  extraPlugins = [
    {
      plugin = pkgs.vimUtils.buildVimPlugin {
        name = "sonarlint.nvim";
        src = pkgs.fetchFromGitLab {
          owner = "schrieveslaach";
          repo = "sonarlint.nvim";
          rev = "main";
          hash = "sha256-+GWsZuS3/inc4HGVuDxSEQjpIXlhldG3HDNUBU/UwIg=";
        };
      };
    }
  ];

  plugins.nvim-jdtls = with pkgs; let
    root_dir =
      # lua
      ''
        require("jdtls.setup").find_root({ "packageInfo" })
          or require("jdtls.setup").find_root({ "mvnw", "gradlew", ".git" })
      '';
  in {
    enable = true;
    cmd = [];
    extraOptions = {
      cmd = [
        "${lib.getExe pkgs.jdt-language-server}"
        "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"
        "-configuration"
        {
          __raw =
            # lua
            ''
              vim.fn.stdpath("cache") .. "/jdtls/config"
            '';
        }
        "-data"
        {
          __raw =
            # lua
            ''
              vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(${root_dir}, ":p:h:t")
            '';
        }
      ];
      on_attach.__raw =
        #lua
        ''
          function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

            require("sonarlint").setup({
              server = {
                cmd = {
                  "${lib.getExe sonarlint-ls}",
                  "-stdio",
                  "-analyzers",
                  vim.fn.expand("${sonarlint-ls}/share/plugins/sonarjava.jar"),
                },
              },
              filetypes = { "java" },
            })
          end
        '';
    };
    rootDir.__raw = root_dir;
    settings = {
      java = {
        inlayHints = {
          parameterNames.enabled = "all";
        };
      };
    };
  };
}
