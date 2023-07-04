{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = [ pkgs.snapper ];

    services.snapper.configs = {
      home = {
        SUBVOLUME = "/home";
        ALLOW_GROUPS = ["users"];
        TIMELINE_CLEANUP = true;
        TIMELINE_CREATE = true;
      };
    };
  };
}
