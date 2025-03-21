{
  imports = [
    ./lua.nix
    ./nix.nix
  ];

  plugins = {
    conform-nvim.enable = true;
    lint.enable = true;
    lsp.enable = true;
  };
}
