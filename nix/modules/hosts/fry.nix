{ config, pkgs, ... }:

{
  networking.hostName = "fry";
  boot.initrd.kernelModules = ["amdgpu"];
}
