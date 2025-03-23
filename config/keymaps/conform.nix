{helper, ...}: let
  inherit (helper) mkLuaBinding;
in {
  keymaps = [
    (
      mkLuaBinding "<leader>fb"
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
