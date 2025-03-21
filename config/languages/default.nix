{
  imports = [
    ./nix.nix
  ];

  plugins = {
    conform-nvim.enable = true;
    lsp.enable = true;
  };
}
