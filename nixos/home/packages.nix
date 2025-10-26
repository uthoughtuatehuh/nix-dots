{ config, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # Editors
    vscodium
    micro

    # Terminal and shell
    kitty
    fish

    # System utilities
    usbutils
    pamixer
    cmake
    unzip
    wget
    btop
    tree
    htop
    fzf
    git
    jq

    # Wayland utilities
    wl-clipboard
    hyprlock
    mpvpaper
    ydotool
    fuzzel
    zenity
    ffmpeg
    waybar
    slurp
    grim
    rofi

    # File management
    file-roller
    nautilus
    gvfs

    # Audio and media
    pavucontrol
    easyeffects
    # obs-studio
    (obs-studio.override {
      ffmpeg = ffmpeg-full;
    })
    playerctl
    spotify
    swappy
    cava
    vlc
    mpv

    # GUI and desktop utilities
    gnome-control-center
    gnome-themes-extra
    dconf-editor
    gnome-boxes
    libadwaita
    flameshot
    libnotify
    nwg-look
    dunst

    # Communication
    telegram-desktop

    # Wine and compatibility
    winetricks
    protonplus
    wine

    # Development
    nodejs

    # Themes and cursors
    bibata-cursors
    adw-gtk3
  ];
}
