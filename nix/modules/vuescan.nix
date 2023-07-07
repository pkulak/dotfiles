{ stdenv
, fetchurl
, gnutar
, autoPatchelfHook
, glibc
, gtk2
, xorg
, libgudev
, undmg
, makeDesktopItem
, ...
}:

let
  pname = "vuescan";
  version = "9.8.11";

  desktopItem = makeDesktopItem {
    name = "VueScan";
    desktopName = "VueScan";
    genericName = "Scanner";
    comment = "VueScan Scanner Software";
    icon = "vuescan";
    terminal = false;
    type = "Application";
    startupNotify = true;
    categories = [ "Utility" ];
    keywords = [ "scan" "scanner" ];

    exec = "vuescan";
  };

  src = fetchurl {
    url = "https://public.kulak.us/vuex64.tgz";
    sha256 = "fun6LxFYt1wSmr56X9eu4WSsB+zQ+BWkP7oZCmbsAT8=";
  };

in
  stdenv.mkDerivation rec {
    inherit pname version src;

    # Stripping the binary breaks the license form
    dontStrip = true;

    nativeBuildInputs = [
      gnutar
      autoPatchelfHook
    ];

    buildInputs = [
      glibc
      gtk2
      xorg.libSM
      libgudev
    ];

    unpackPhase = ''
      tar xfz $src
    '';

    installPhase = ''
      install -m755 -D VueScan/vuescan $out/bin/vuescan

      mkdir -p $out/share/icons/hicolor/scalable/apps/
      cp VueScan/vuescan.svg $out/share/icons/hicolor/scalable/apps/vuescan.svg 

      mkdir -p $out/lib/udev/rules.d/
      cp VueScan/vuescan.rul $out/lib/udev/rules.d/60-vuescan.rules

      mkdir -p $out/share/applications/
      ln -s ${desktopItem}/share/applications/* $out/share/applications
    '';
  }

