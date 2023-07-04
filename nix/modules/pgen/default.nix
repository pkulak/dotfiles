{ lib
, rustPlatform
, fetchFromGitHub
, ...
}:

rustPlatform.buildRustPackage rec {
  pname = "pgen";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "pkulak";
    repo = "pgen";
    rev = version;
    hash = "sha256-VyUDJLwbEci3qQPDMsO2GTrOFO1c0KOB+h5DzuNKxhQ=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "clap-3.0.0-beta.1" = "sha256-O5HOBV6lnWCGMUzjlLhUGgdJjd9i3FwUOZ1ay8pbWMw=";
    };
  };

  meta = with lib; {
    description = "Generate the right password";
    homepage = "https://github.com/pkulak/pgen";
    license = with licenses; [ ];
    maintainers = with maintainers; [ ];
  };
}
