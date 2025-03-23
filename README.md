# nixvim

Modular, configurable, reproducible and easy to use personal Neovim
configuration in Nix using [nixvim](https://github.com/nix-community/nixvim)

## Run using `nix run`

```sh
nix run \
    --extra-experimental-features nix-command \
    --extra-experimental-features flakes \
    github:venkyr77/nixvim
```

## Run as a standalone flake

A simple standalone flake that makes this package as default

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim = {
      url = "github:venkyr77/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {system, ...}: {
        packages = {inherit (nixvim.packages.${system}) default;};
      };
    };
}
```

and then run using `nix run` by,

```sh
nix run \
    --extra-experimental-features nix-command \
    --extra-experimental-features flakes \
    .
```
