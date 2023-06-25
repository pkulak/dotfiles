{ config, pkgs, ... }:

let
  vim-symlink = pkgs.writeTextFile {
    name = "vim";
    destination = "/bin/vim";
    executable = true;

    text = ''
      #!/usr/bin/env bash
      nvim "''${@:1}"
    '';
  };

in
{
  config = {
    environment.systemPackages = with pkgs; [
      neovim
      vim-symlink
    ];
  };
}
