{
  mkLua = lua: ''
    lua << EOF
      ${lua}
    EOF
  '';
  mkBinding = mode: key: action: desc: {
    inherit action key mode;
    options = {
      inherit desc;
      silent = true;
    };
  };
  mkLuaBinding = mode: key: action: desc: {
    action.__raw = action;
    inherit key mode;
    options = {
      inherit desc;
      silent = true;
    };
  };
  getClientCapabilitiesInlineLuaCode = _:
  # lua
  ''
    vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )
  '';
}
