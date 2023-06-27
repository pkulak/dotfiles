{ config, pkgs, ... }:

let
  matui = pkgs.rustPlatform.buildRustPackage rec {
    name = "matui";
    version = "0.4.1";
    
    src = pkgs.fetchFromGitHub {
      "owner" = "pkulak";
      "repo" = "matui";
      "rev" = "8393fceef4c9593284b8e7c18c74b237c24ed178";
      "sha256" = "upWq0054aTqBFUkFWgQgqxTguhEHYvdOQr9VsRIh810=";
    };

    cargoLock = {
      lockFile = builtins.path {
        path = src + "/Cargo.lock";
        name = "Cargo.lock";
      };
      allowBuiltinFetchGit = true;
    };

    nativeBuildInputs = [ pkgs.pkg-config ];
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

in
{
  config = {
    environment.systemPackages = with pkgs; [
      matui
    ];
  };
}
