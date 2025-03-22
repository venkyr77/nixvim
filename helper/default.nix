{
  mkLua = lua: ''
    lua << EOF
      ${lua}
    EOF
  '';
  mkBinding = key: action: desc: {
    action.__raw = action;
    inherit key;
    mode = [ "n" ];
    options = {
      inherit desc;
      silent = true;
    };
  };
}
