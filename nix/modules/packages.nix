{ config, pkgs, ... }:
{
  environment = {
    sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [
      # TEST
      pamixer
      # Editors
      micro
      vscodium
      # vim

      # Browsers
      firefox
      chromium

      # Terminal and shell
      kitty
      fish

      # System utilities
      wget
      git
      unzip
      usbutils
      btop
      fastfetch
      fzf
      cmake

      # Wayland utilities
      waybar
      rofi
      wl-clipboard
      mpvpaper
      # hyprpaper
      zenity
      hyprlock
      grim
      slurp
      fuzzel
      ydotool
      ffmpeg
      libva
      libvdpau
      wayland-protocols

      # File management
      nautilus
      file-roller
      gvfs

      # Audio and media
      spotify
      pavucontrol
      playerctl
      swappy
      cava
      vlc
      mpv

      # GUI and desktop utilities
      dunst
      flameshot
      dconf-editor
      gnome-control-center
      gnome-keyring
      gnome-bluetooth
      gnome-themes-extra
      gnome-boxes
      nwg-look
      libnotify
      libadwaita

      # Communication
      vesktop

      # Wine and compatibility
      wine
      winetricks
      protonplus

      # Development
      nodejs

      # Themes and cursors
      bibata-cursors
    ];
  };
}
