{ pkgs, ... }:
{
  plugins.lint = {
    enable = true;
    linters = with pkgs; {
      luacheck.cmd = lib.getExe luajitPackages.luacheck;
      markdownlint.cmd = lib.getExe markdownlint-cli;
      statix.cmd = lib.getExe statix;
    };
    lintersByFt = {
      lua = [ "luacheck" ];
      markdown = [ "markdownlint" ];
      nix = [ "statix" ];
    };
  };
}
