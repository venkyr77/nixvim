{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native = {
        enable = true;
        settings.fuzzy = false;
      };
    };
    settings = {
      defaults = {
        file_ignore_patterns = [
          ".git"
          "build"
        ];
        layout_config = {
          horizontal = {
            height = 0.95;
            width = 0.95;
          };
        };
        path_display = [ "filename_first" ];
        preview.treesitter = true;
      };
    };
  };
}
