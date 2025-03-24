{pkgs, ...}: {
  extraPackages = with pkgs; [
    jdk8
    jdk11
    jdk17
    jdk21
    lombok
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
          end
        '';
    };
    rootDir.__raw = root_dir;
    settings = {
      java = {
        completion.enabled = true;
        configuration.runtimes = with pkgs; [
          {
            name = "JavaSE-1.8";
            path = "${jdk8}";
          }
          {
            name = "JavaSE-11";
            path = "${jdk11}";
          }
          {
            name = "JavaSE-17";
            path = "${jdk17}";
            default = true;
          }
          {
            name = "JavaSE-21";
            path = "${jdk21}";
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
  };
}
