{
  description = "A flake for building the bard-cli Go project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils}:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
    };
    callPackage = pkgs.darwin.apple_sdk_11_0.callPackage or pkgs.callPackage;
    bard-cli = callPackage ./default.nix { };
  in
  {
    pkgs.currentSystem = system;
    defaultPackage = bard-cli;
  }
  );
}
