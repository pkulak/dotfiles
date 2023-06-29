{ config, pkgs, ... }:

{
  config = {
    boot.kernelParams = ["i915.enable_psr=0" "rd.luks.options=discard"];
    programs.light.enable = true;
  };
}
