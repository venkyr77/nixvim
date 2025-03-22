{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    lombok
  ];

  plugins.nvim-jdtls =
    with pkgs;
    let
      root_dir = # lua
        ''
          require("jdtls.setup").find_root({ "packageInfo" })
            or require("jdtls.setup").find_root({ "mvnw", "gradlew", ".git" })
        '';
    in
    {
      enable = true;
      cmd = [ ];
      extraOptions.cmd = [
        "${lib.getExe pkgs.jdt-language-server}"
        "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"
        "-configuration"
        {
          __raw = # lua
            ''
              vim.fn.stdpath("cache") .. "/jdtls/config"
            '';
        }
        "-data"
        {
          __raw = # lua
            ''
              vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(${root_dir}, ":p:h:t")
            '';
        }
      ];
      rootDir.__raw = root_dir;
    };
}
