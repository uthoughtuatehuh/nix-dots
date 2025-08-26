{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Editors
    micro
    vscodium

    # Browsers
    firefox
    chromium

    # Terminal and shell
    kitty
    fish

    # System utilities
    pamixer
    wget
    git
    unzip
    usbutils
    btop
    fastfetch
    fzf
    cmake
    tree
    htop

    # Wayland utilities
    waybar
    rofi
    wl-clipboard
    mpvpaper
    zenity
    hyprlock
    grim
    slurp
    fuzzel
    ydotool
    ffmpeg

    # File management
    nautilus
    file-roller
    gvfs

    # Audio and media
    spotify
    pavucontrol
    playerctl
    obs-studio
    swappy
    cava
    vlc
    mpv

    # GUI and desktop utilities
    dunst
    flameshot
    dconf-editor
    gnome-control-center
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

    # Fonts
    nerd-fonts.symbols-only
    noto-fonts
  ];
}
