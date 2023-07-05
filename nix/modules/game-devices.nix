{
  stdenvNoCC,
  fetchFromGitLab,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "game-devices";
  version = "20230523";

  src = fetchFromGitLab {
    owner = "fabiscafe";
    repo = "game-devices-udev";
    rev = "eddda2a2f268df0e9e14a99564431f880f88c5a6";
    sha256 = "sha256-0H2yQM5ZrSHl2/rLTB0pjaPI1ZyBxPRcl9CA83HxcBs=";
  };

  installPhase = ''
    rm 71-powera*
    mkdir -p $out/lib/udev/rules.d
    cp *.rules $out/lib/udev/rules.d/
  '';
}
