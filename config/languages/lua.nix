{ pkgs, ... }:
{
  plugins = {
    lsp.servers.lua_ls.enable = true;
    conform-nvim.settings = with pkgs; {
      formatters.stylua.command = lib.getExe stylua;
      formatters_by_ft.lua = [ "stylua" ];
    };
    lint = with pkgs; {
      linters.luacheck.cmd = lib.getExe luajitPackages.luacheck;
      lintersByFt.lua = [ "luacheck" ];
    };
  };
}
