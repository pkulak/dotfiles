{ config, pkgs, ... }:

{
  networking.hostName = "x260";
  boot.kernelParams = ["i915.enable_psr=0"];
  programs.light.enable = true;
}
