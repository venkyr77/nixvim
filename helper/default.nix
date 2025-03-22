{
  mkLua = lua: ''
    lua << EOF
      ${lua}
    EOF
  '';
  mkBinding = key: action: desc: {
    inherit action key;
    mode = [ "n" ];
    options = {
      inherit desc;
      silent = true;
    };
  };
  mkLuaBinding = key: action: desc: {
    action.__raw = action;
    inherit key;
    mode = [ "n" ];
    options = {
      inherit desc;
      silent = true;
    };
  };
}
