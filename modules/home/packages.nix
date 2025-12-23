{ config, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    virt-manager          # графический менеджер VM
    virt-viewer           # подключение к консоли VM
    swtpm                 # софтовая эмуляция TPM2 (уже включена выше, но иногда нужен бинарник)
    OVMF                  # прошивка UEFI (включает и OVMF_CODE.secboot.fd)
    qemu_kvm              # сам QEMU
    dnsmasq               # libvirt его использует для NAT-сетей
    bridge-utils          # если будете делать bridge-сети
    libguestfs            # полезно для работы с образами дисков
    libguestfs-appliance  # ^
    # Editors
    kdePackages.kate
    vscodium
    micro

    # Terminal and shell
    kitty
    fish

    # System utilities
    openssl_legacy
    cpulimit
    usbutils
    pamixer
    parted
    cmake
    unzip
    aria2
    ncdu
    nmap
    wget
    btop
    tree
    htop
    dig
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
    kdePackages.kdenlive
    pavucontrol
    easyeffects
    playerctl
    spotify
    evince
    swappy
    krita
    cava
    vlc
    mpv

    # GUI and desktop utilities
    gnome-control-center
    gnome-themes-extra
    dconf-editor
    gnome-boxes
    amnezia-vpn
    libreoffice
    libadwaita
    wireshark
    flameshot
    libnotify
    obsidian
    nwg-look

    # Communication
    telegram-desktop

    # Wine and compatibility
    # wineWowPackages.stable
    winetricks
    protonplus
    lutris
    wine

    # Development
    openjdk17
    nodejs

    # Themes and cursors
    bibata-cursors
    adw-gtk3

    # Reverse Engineering & Low-level tools
    # imhex
    binutils
    radare2
    strace
    ltrace
    ghidra
    cutter
    rizin
    lurk
    file
    gdb
  ];
}
