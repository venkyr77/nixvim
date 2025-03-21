{
  plugins.neo-tree = {
    enable = true;
    defaultComponentConfigs.indent.withExpanders = true;
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
    window.mappings = {
      "\\" = "close_window";
    };
  };
}
