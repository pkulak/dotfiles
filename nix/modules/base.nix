{ config, pkgs, ... }:

{
  imports = [ 
    ./snapper.nix
    ./smb.nix
    ./sublime-music.nix
    ./sway.nix
  ];

  config = {
    environment.systemPackages = with pkgs; [
      age
      btop
      bc
      cached-nix-shell
      exa
      chezmoi
      distrobox
      ffmpeg
      firefox
      git
      glib
      gnome.zenity
      gocryptfs
      imv
      lf
      mpv
      networkmanagerapplet
      pamixer
      pavucontrol
      podman
      ripgrep
      sublime-merge
      tldr
      woeusb
      xdragon
      yt-dlp

      (pkgs.callPackage ./matui/default.nix pkgs)
      (pkgs.callPackage ./pgen/default.nix pkgs)
    ];

    # Udev rule for game controllers
    services.udev.packages = [ (pkgs.callPackage ./game-devices.nix pkgs) ];

    # Create a timer to auto-upgrade
    system.autoUpgrade.enable = true;

    # Tame the proxy a bit to let Wireguard work
    networking.firewall.checkReversePath = false;

    # Allow users to nice down to -10
    security.pam.loginLimits = [
      { domain = "phil"; type = "-"; item = "nice"; value = "-10"; }
      { domain = "phil"; type = "-"; item = "nofile"; value = "1048576"; }
    ];

    programs.fish.enable = true;

    services.flatpak.enable = true;

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
      };
    };

    virtualisation.containers.enable = true;

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    fonts = {
      enableDefaultFonts = true;
      fonts = with pkgs; [ 
        cantarell-fonts
        ubuntu_font_family
	      noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
      ];

      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Serif" ];
          sansSerif = [ "Cantarell" ];
          monospace = [ "Ubuntu Mono" ];
        };
      };
    };
  };
}
