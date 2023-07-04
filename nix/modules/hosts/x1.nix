{ config, pkgs, ... }:

{
  networking.hostName = "x1";
  programs.light.enable = true;
}
