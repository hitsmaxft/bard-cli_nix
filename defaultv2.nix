{ 
  pkgs,
  pkgs2 ? (
    let
      sources = import ./nix/sources.nix;
    in
    import sources.nixpkgs {
      system = pkgs.system;
      overlays = [
        (import "${sources.gomod2nix}/overlay.nix")
      ];
    }
    ),
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
  pkgs2.buildGoApplication {
    pname = pname;
    version = version;
    pwd = ./.;
    src = "${src}";
    modules = ./gomod2nix.toml;
  }

