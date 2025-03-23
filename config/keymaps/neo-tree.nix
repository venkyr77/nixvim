{helper, ...}: let
  inherit (helper) mkBinding;
in {
  keymaps = [
    (mkBinding "\\" ":Neotree toggle<CR>" "toggle neo-tree")
  ];
}
