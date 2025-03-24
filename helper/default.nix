{
  mkLua = lua: ''
    lua << EOF
      ${lua}
    EOF
  '';
  mkBinding = key: action: desc: {
    inherit action key;
    mode = ["n"];
    options = {
      inherit desc;
      silent = true;
    };
  };
  mkLuaBinding = key: action: desc: {
    action.__raw = action;
    inherit key;
    mode = ["n"];
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
