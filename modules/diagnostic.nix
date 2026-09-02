{
  flake.modules.nixvim.diagnostic = { lib, ... }: {
    diagnostic.settings.virtual_lines.format =
      lib.nixvim.mkRaw
        # lua
        ''
          function(diagnostic)
            return string.format(
              "%s (%s)",
              diagnostic.message,
              diagnostic.source or vim.diagnostic.get_namespace(diagnostic.namespace).name
            )
          end
        '';
  };
}
