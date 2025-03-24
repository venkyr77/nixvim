{helper, ...}: let
  inherit (helper) mkLuaBinding;
in {
  keymaps = [
    (
      mkLuaBinding ["n" "v"] "<leader>fb"
      # lua
      ''
        function()
            require("conform").format()
        end
      ''
      "format [b]uffer"
    )
  ];
}
