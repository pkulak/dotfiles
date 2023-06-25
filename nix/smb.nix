{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = [ pkgs.cifs-utils ];

    fileSystems."/mnt/nas" = {
        device = "//lilnas.home/home";
        fsType = "cifs";
        options = let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=phil,gid=users";

        in ["${automount_opts},credentials=/home/phil/nix/smb-secrets"];
    };

    fileSystems."/mnt/music" = {
        device = "//lilnas.home/music";
        fsType = "cifs";
        options = let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=phil,gid=users";

        in ["${automount_opts},credentials=/home/phil/nix/smb-secrets"];
    };
  };
}
