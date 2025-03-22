{
  plugins.neo-tree = {
    enable = true;
    defaultComponentConfigs.indent.withExpanders = true;
    extraOptions.enable_cursor_hijack = true;
    filesystem = {
      filteredItems = {
        hideDotfiles = false;
        neverShow = [
          ".git"
        ];
      };
      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = true;
      };
      groupEmptyDirs = true;
      scanMode = "deep";
    };
  };
}
