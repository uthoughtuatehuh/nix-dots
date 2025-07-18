{ config, pkgs, ... }:

{
  # Import hardware configuration
  imports = [
    ./hardware-configuration.nix
    ./modules/hyprland/default.nix
    ./modules/rofi/default.nix
    ./modules/waybar/default.nix
  ];

  # Bootloader configuration
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/nvme0n1";
        useOSProber = true;
        enableCryptodisk = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      luks.devices = {
        "luks-0b0f7811-085a-4565-8f05-02538d52cefe" = {
          device = "/dev/disk/by-uuid/0b0f7811-085a-4565-8f05-02538d52cefe";
          keyFile = "/boot/crypto_keyfile.bin";
        };
        "luks-8cf7c3ca-86ca-4b51-ad1b-73d31f753f69" = {
          keyFile = "/boot/crypto_keyfile.bin";
        };
      };
      secrets = {
        "/boot/crypto_keyfile.bin" = null;
      };
    };
  };

  # Networking configuration
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # wireless.enable = true; # Enables wireless support via wpa_supplicant
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Time zone and internationalization
  time.timeZone = "Europe/Moscow";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  # File system configuration
  fileSystems."/mnt/d" = {
    device = "/dev/disk/by-uuid/ae58d928-cb9f-46a7-84ce-4239e2b575ed";
    fsType = "ext4";
    options = [ "defaults" "noatime" ];
  };

  # DNS configuration
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
  };

  # Virtualisation
  virtualisation.libvirtd.enable = true;

  # VPN configuration
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # X11 and Wayland configuration
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Security and user configuration
  security = {
    doas = {
      enable = true;
      extraRules = [{
        users = [ "user" ];
        keepEnv = true;
        persist = true;
      }];
    };
    sudo.enable = false;
  };

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" "libvirt" ];
    packages = with pkgs; [];
  };

  # Graphics and NVIDIA configuration
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        vulkan-loader
        libglvnd
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vulkan-loader
        libglvnd
      ];
    };
  };

  # UDEV rules for specific hardware
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="1054", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="1054", TAG+="uaccess"
  '';

  # Environment settings
  environment = {
    sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [    
      # Editors
      micro
      vscodium
      # vim # Uncomment to include vim as an alternative editor

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
      hyprpaper
      hyprlock
      grim
      slurp
      fuzzel
      ydotool

      # File management
      nautilus
      file-roller
      gvfs

      # Audio and media
      spotify
      pavucontrol
      playerctl
      cava
      vlc

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

      # Development
      nodejs

      # Themes and cursors
      bibata-cursors
    ];
  };

  # Font configuration
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
    ];
    fontconfig.enable = true;
  };

  # Nix package manager settings
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  # System version
  system.stateVersion = "25.05";
}
