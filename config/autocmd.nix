{
  autoCmd = [
    {
      callback.__raw =
        # lua
        ''
          function()
            local ignore_filetypes = {
              "help",
              "neo-tree",
              "notify",
              "trouble",
            }
            if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
              vim.b.miniindentscope_disable = true
            end
          end
        '';
      desc = "Disable indentscope for certain filetypes";
      event = ["FileType"];
    }
  ];
}
