{ config, pkgs, ... }:

{
  imports = [ 
    ./snapper.nix
    ./smb.nix
    ./sway.nix
    ./vim.nix
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
      podman
      ripgrep
      sublime-merge
      sublime-music
      xdragon
      yt-dlp
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
