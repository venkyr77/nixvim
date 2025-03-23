{helper, ...}: let
  inherit (helper) mkBinding;
in {
  imports = [
    ./cmp.nix
    ./conform.nix
    ./gitsigns.nix
    ./lsp.nix
    ./neo-tree.nix
    ./telescope.nix
  ];

  keymaps = [
    (mkBinding "<Esc>" "<cmd>nohlsearch<CR>" "Clear search highlights")
  ];
}
