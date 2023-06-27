{ config, pkgs, ... }:

let
  buzz = pkgs.rustPlatform.buildRustPackage rec {
    name = "buzz";
    version = "1.7.0";
    
    src = pkgs.fetchFromGitHub {
      owner = "jonhoo";
      repo = "buzz";
      rev = "07cf74e3863f01213e37488926e7dc07e9ac004f";
      sha256 = "lzr+DS8UpKkzUxXRjEXD/U6HyRkaM/Q7GFfAM2PJXYw=";
    };

    cargoLock = {
      lockFile = builtins.path {
        path = src + "/Cargo.lock";
        name = "Cargo.lock";
      };
      allowBuiltinFetchGit = true;
    };

    nativeBuildInputs = [ pkgs.pkg-config ];
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.glib.dev}/lib/pkgconfig:${pkgs.pango.dev}/lib/pkgconfig:${pkgs.harfbuzz.dev}/lib/pkgconfig:${pkgs.cairo.dev}/lib/pkgconfig:${pkgs.gdk-pixbuf.dev}/lib/pkgconfig:${pkgs.gtk3.dev}/lib/pkgconfig";
  };

in
{
  config = {
    environment.systemPackages = with pkgs; [
      buzz
    ];
  };
}
