{
  plugins.bufferline = {
    enable = true;
    settings.options = {
      close_command.__raw =
        # lua
        ''
          function(n)
            require("mini.bufremove").delete(n, false)
          end
        '';
      diagnostics = "nvim_lsp";
      diagnostics_indicator =
        # lua
        ''
          function(_, _, diagnostics_dict, _)
            local s = ""
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " " or (e == "warning" and " " or "")
              if sym ~= "" then
                s = s .. " " .. n .. sym
              end
            end
            return s
          end
        '';
      indicator.style = "underline";
      modified_icon = "●";
      numbers.__raw =
        # lua
        ''
          function(opts)
            return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
          end
        '';
      offsets = [
        {
          filetype = "neo-tree";
          highlight = "Directory";
          separator = true;
          text = "Explorer";
          text_align = "center";
        }
      ];
    };
  };
}
