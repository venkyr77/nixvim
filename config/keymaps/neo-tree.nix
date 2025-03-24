{helper, ...}: let
  inherit (helper) mkBinding;
in {
  keymaps = [
    (mkBinding ["n"] "\\" ":Neotree toggle<CR>" "toggle neo-tree")
  ];
}
