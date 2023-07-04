{ config, pkgs, ... }:

let
  start-sway = pkgs.writeTextFile {
    name = "start-sway";
    destination = "/bin/start-sway";
    executable = true;

    text = ''
      #!/bin/sh

      ## Internal variables
      SWAY_EXTRA_ARGS=""
      
      ## General exports
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
      
      ## Hardware compatibility
      # We can't be sure that the virtual GPU is compatible with Sway.
      # We should be attempting to detect an EGL driver instead, but that appears
      # to be a bit more complicated.
      case $(systemd-detect-virt --vm) in
          "none"|"")
              ;;
          "kvm")
              # https://github.com/swaywm/sway/issues/6581
              export WLR_NO_HARDWARE_CURSORS=1
              # There's two drivers we can get here, depending on the 3D acceleration
              # flag state: either virtio_gpu/virgl or kms_swrast/llvmpipe.
              #
              # The former one causes graphical glitches in OpenGL apps when using
              # 'pixman' renderer. The latter will crash 'gles2' renderer outright.
              # Neither of those support 'vulkan'.
              #
              # The choice is obvious, at least until we learn to detect the driver
              # instead of abusing the virtualization technology identifier.
              #
              # See also: https://gitlab.freedesktop.org/wlroots/wlroots/-/issues/2871
              export WLR_RENDERER=pixman
              ;;
          *)
              # https://github.com/swaywm/sway/issues/6581
              export WLR_NO_HARDWARE_CURSORS=1
              ;;
      esac
      
      ## Load system environment customizations
      if [ -f /etc/sway/environment ]; then
          set -o allexport
          # shellcheck source=/dev/null
          . /etc/sway/environment
          set +o allexport
      fi
      
      ## Load user environment customizations
      if [ -f "''${XDG_CONFIG_HOME:-$HOME/.config}/sway/environment" ]; then
          set -o allexport
          # shellcheck source=/dev/null
          . "''${XDG_CONFIG_HOME:-$HOME/.config}/sway/environment"
          set +o allexport
      fi
      
      ## Unexport internal variables
      # export -n is not POSIX :(
      _SWAY_EXTRA_ARGS="$SWAY_EXTRA_ARGS"
      unset SWAY_EXTRA_ARGS
      
      # Start sway with extra arguments and send output to the journal
      # shellcheck disable=SC2086 # quoted expansion of EXTRA_ARGS can produce empty field
      exec systemd-cat -- sway $_SWAY_EXTRA_ARGS "$@"
    '';
  };

in
{
  config = {
    environment.systemPackages = with pkgs; [
      alacritty
      gnome.adwaita-icon-theme
      gnome.gnome-themes-extra
      grim
      mako
      playerctl
      slurp
      start-sway
      swayidle
      swayimg
      waybar
      wayland
      wlsunset
      wl-clipboard
      wofi
      xdg-utils
    ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };
}
