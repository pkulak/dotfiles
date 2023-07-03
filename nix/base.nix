{ config, pkgs, ... }:

{
  imports = [ 
    ./snapper.nix
    ./smb.nix
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
      sublime-music
      tldr
      woeusb
      xdragon
      yt-dlp
    ];

    # Udev rule for game controllers
    services.udev.packages = [ (pkgs.callPackage ./gamedevices.nix pkgs) ];

    # Create a timer to auto-upgrade
    system.autoUpgrade.enable = true;

    # Tame the proxy a bit to let Wireguard work
    networking.firewall.checkReversePath = false;

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
