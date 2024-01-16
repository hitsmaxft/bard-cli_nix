{
  description = "A flake for building the bard-cli Go project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        src = pkgs.fetchFromGitHub {
          owner = "mosajjal";
          repo = "bard-cli";
          rev = "master"; # Replace with a specific commit or tag if necessary
          sha256 = "l3WaK+VwoZU/R/HII6S4pAx+KhVFRhrVmvIVrz7wpQw="; # Replace with the actual SHA256 of the desired revision
        };
      in
      {
        packages.bard-cli = pkgs.stdenv.mkDerivation {
          pname = "bard-cli";
          version = "1.0.0"; # Replace with the actual version

          inherit src;

          buildInputs = [ pkgs.go ];

          buildPhase = ''
            runHook preBuild
            export GOCACHE=/tmp/
            cd $src
            go build
            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall
            mkdir -p $out/bin
            cp -r $src/bard-cli $out/bin/
            runHook postInstall
          '';

          meta = with pkgs.lib; {
            description = "A CLI tool for bard";
            homepage = "https://github.com/mosajjal/bard-cli";
            license = licenses.mit;
            maintainers = with maintainers; [ ]; # Add maintainers here
          };
        };

        defaultPackage.system = self.packages.bard-cli;
      }
    );
}
