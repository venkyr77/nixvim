{ helper, ... }:
let
  inherit (helper) mkBinding;
in
{
  keymaps = [
    (mkBinding "<leader>fb"
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
