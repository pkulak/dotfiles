{ config, pkgs, ... }:

let
  nixos-hardware = import (fetchTarball("https://github.com/NixOS/nixos-hardware/archive/master.tar.gz")) {};
in {
  imports = [ <nixos-hardware/lenovo/thinkpad/x1/6th-gen> ]
  networking.hostName = "x1";
  programs.light.enable = true;
}
