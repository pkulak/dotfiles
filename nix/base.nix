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
      pavucontrol
      podman
      ripgrep
      sublime-merge
      sublime-music
      xdragon
      yt-dlp
    ];

    services.udev.packages = [ (pkgs.callPackage ./gamedevices.nix pkgs) ];
    services.flatpak.enable = true;

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
      };
    };

    system.autoUpgrade.enable = true;
    
    networking.firewall.checkReversePath = false;

    virtualisation.containers.enable = true;

    programs.fish.enable = true;

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
          serif = [ "Ubuntu" ];
          sansSerif = [ "Ubuntu" ];
          monospace = [ "Ubuntu" ];
        };
      };
    };
  };
}
