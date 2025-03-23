{
  pkgs,
  helper,
  ...
}: {
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = smartyank-nvim;
      config =
        helper.mkLua
        # lua
        ''
          require("smartyank").setup({ osc52 = { ssh_only = false } })
        '';
    }
  ];
}
