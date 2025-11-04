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
    parted
    cmake
    unzip
    ncdu
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
    libreoffice
    libadwaita
    wireshark
    flameshot
    libnotify
    nwg-look

    # Communication
    telegram-desktop

    # Wine and compatibility
    winetricks
    protonplus
    wine

    # Development
    openjdk17
    nodejs

    # Themes and cursors
    bibata-cursors
    adw-gtk3
  ];
}
