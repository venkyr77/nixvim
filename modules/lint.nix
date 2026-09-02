{ inputs, ... }: {
  flake.modules.nixvim.lint =
    {
      lib,
      pkgs,
      ...
    }:
    {
      plugins.lint = {
        autoCmd.event = [
          "BufEnter"
          "BufWritePost"
          "InsertLeave"
        ];
        enable = true;
        linters = {
          deadnix.cmd = lib.getExe pkgs.deadnix;
          ruff.cmd = lib.getExe pkgs.ruff;
          statix.cmd = lib.getExe pkgs.statix;
        };
        lintersByFt = {
          nix = [
            "deadnix"
            "statix"
          ];
          python = [
            "ruff"
          ];
        };
        package = inputs.self.nvimPluginPins.nvim-lint;
      };
    };
}
