{ pkgs? import <nixpkgs> {} }:

let
  fetchFromGitHub = pkgs.fetchFromGitHub;
  stdenv = pkgs.stdenv;
  pname = "bard-cli";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "hitsmaxft";
    repo = "bard-cli";
    rev = "9e298bb19bf92c74372809c3f601b2fdfd9ddb01"; # Replace with a specific commit or tag if necessary
    sha256 = "QgjHoLR01QPgbBRl/zwofa7T8knYYoSagTdFa3HXR9I="; # Replace with the actual SHA256 of the desired revision
    };
in
  import "${src}/default.nix" {
    pname = pname;
    pversion = version;
  } 
