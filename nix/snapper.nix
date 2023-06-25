{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = [ pkgs.snapper ];

    services.snapper.configs = {
      home = {
        subvolume = "/home";

        extraConfig = ''
          ALLOW_GROUPS="users"
          TIMELINE_CREATE="yes"
          TIMELINE_CLEANUP="yes"
          TIMELINE_MIN_AGE="1800"
          TIMELINE_LIMIT_HOURLY="12"
          TIMELINE_LIMIT_DAILY="7"
          TIMELINE_LIMIT_WEEKLY="4"
          TIMELINE_LIMIT_MONTHLY="0"
          TIMELINE_LIMIT_YEARLY="0"
        '';
      };
    };
  };
}
