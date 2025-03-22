{ pkgs, ... }:
{
  plugins.lint = {
    autoCmd.event = [
      "BufEnter"
      "BufWritePost"
      "InsertLeave"
    ];
    enable = true;
    linters = with pkgs; {
      luacheck.cmd = lib.getExe luajitPackages.luacheck;
      markdownlint.cmd = lib.getExe markdownlint-cli;
      shellcheck.cmd = lib.getExe shellcheck;
      statix.cmd = lib.getExe statix;
    };
    lintersByFt = {
      lua = [ "luacheck" ];
      markdown = [ "markdownlint" ];
      nix = [ "statix" ];
      sh = [ "shellcheck" ];
      zsh = [ "shellcheck" ];
    };
  };
}
