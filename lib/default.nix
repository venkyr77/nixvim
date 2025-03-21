{
  mkLua = lua: ''
    lua << EOF
      ${lua}
    EOF
  '';
}
