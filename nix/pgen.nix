{ config, pkgs, ... }:

let
  pgen = pkgs.rustPlatform.buildRustPackage rec {
    name = "pgen";
    version = "1.0.0";
    
    src = pkgs.fetchFromGitHub {
      "owner" = "pkulak";
      "repo" = "pgen";
      "rev" = "bbe1d17a82753e1665f52f6ea58de5d7e8bd6867";
      "sha256" = "htCh+Su6udqPF/91TUl/tpWTED3tYxCkyU2PWYoJVkY=";
    };

    cargoLock = {
      lockFile = builtins.path {
        path = src + "/Cargo.lock";
        name = "Cargo.lock";
      };
      allowBuiltinFetchGit = true;
    };
  };

in
{
  config = {
    environment.systemPackages = with pkgs; [
      pgen
    ];
  };
}
