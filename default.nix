{ 
  pkgs,
  gomod2nix ? (
    let
      sources = import ./nix/sources.nix;
      inherit (pkgs.callPackage "${sources.gomod2nix}/builder" {
        inherit gomod2nix;
      }) mkGoEnv buildGoApplication;
      gomod2nix = pkgs.callPackage "${sources.gomod2nix}/default.nix" {
        inherit mkGoEnv buildGoApplication;
    };
    in
      gomod2nix
    )
  }:

  let
    fetchFromGitHub = pkgs.fetchFromGitHub;
    stdenv = pkgs.stdenv;
    pname = "bard-cli";
    version = "0.3.6";

    src = fetchFromGitHub {
      owner = "mosajjal";
      repo = "bard-cli";
      rev = "v0.3.6"; # Replace with a specific commit or tag if necessary
      sha256 = "sha256-qoO9loiGpAVKC2ZOYG0RqUSWP1YVlOrwqvPwuLYiuYo="; # Replace with the actual SHA256 of the desired revision
    };
  in
  gomod2nix.buildGoApplication {
    pname = pname;
    version = version;
    pwd = ./.;
    src = "${src}";
    modules = ./gomod2nix.toml;
  }

