{
  plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = false;
      highlight = {
        additional_vim_regex_highlighting = true;
        enable = true;
      };
      indent.enable = true;
    };
  };
}
