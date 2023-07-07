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
      file
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
        PasswordAuthentication = false;
      };
    };

    users.users.phil = {
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA2lQGc0oA11Lgo+C3Mo9gYAWsvv/G3vA5lGoHISJ5mGLGZEcFol7coxVjtzkoWE1k0blwGPUwc1aDMwCz7Nmz5nD8GLl9J3OLi3YynmsQAiqM07D/RPLq7YqtkDOLTIwTbBV6SpX+ytw/hLT8LnWen4VwIDHPTzWMrirTGJK5BFD7jEXhHFS/ZSgoxYqA5rie3GrJ7JK/Wy7/+rJjD/JSaswcefVi5aESXJQS2aur2HYK90ZeG+YdYL7+NNYdfapz3BFgIjTf8SAOlo9NN3NSUjb58HdtCWLNRMfji/fEdy0WsA0I4/mMxBqih9zb2TWsyDj0tp6IYyVlmOpIKdKkgQ== phil@fry" ];
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
