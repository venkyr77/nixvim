{ pkgs, ... }:
{
  plugins.lint = {
    enable = true;
    linters = with pkgs; {
      luacheck.cmd = lib.getExe luajitPackages.luacheck;
      statix.cmd = lib.getExe statix;
    };
    lintersByFt = {
      lua = [ "luacheck" ];
      nix = [ "statix" ];
    };
  };
}
