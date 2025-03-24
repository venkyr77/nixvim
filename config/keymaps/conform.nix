{helper, ...}: let
  inherit (helper) mkLuaBinding;
in {
  keymaps = [
    (
      mkLuaBinding ["n" "v"] "<leader>lf"
      # lua
      ''
        function()
            require("conform").format()
        end
      ''
      "[f]ormat buffer or selection using conform"
    )
  ];
}
