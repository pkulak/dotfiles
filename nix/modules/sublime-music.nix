{ config, pkgs, ... }:

with pkgs; let
  patchDesktop = pkg: appName: from: to: lib.hiPrio (pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
    ${coreutils}/bin/mkdir -p $out/share/applications
    ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
  '');
in {
  config = {
    environment.systemPackages = [
        sublime-music
        (patchDesktop sublime-music "sublime-music" "^Exec=sublime-music" "Exec=nice --10 sublime-music")
    ];
  };
}
