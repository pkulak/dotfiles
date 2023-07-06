{ config, pkgs, ... }:

{
  imports = [ <nixos-hardware/lenovo/thinkpad/x1/6th-gen> ]
  networking.hostName = "x1";
  programs.light.enable = true;
}
