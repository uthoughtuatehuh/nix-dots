{ pkgs, modulesPath, lib, config, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  networking.hostName = "nixos-iso";

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "nixos";
  };

  services.getty.autologinUser = "nixos";

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    wl-clipboard
  ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="1054", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="1054", TAG+="uaccess"
  '';

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
        vulkan-loader
        libglvnd
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vulkan-loader
        libglvnd
      ];
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  services = {  
    gnome = {
      gnome-keyring.enable = true;
      gcr-ssh-agent.enable = true;
    };
  };

  programs = {
    throne = {
      enable = true;
      tunMode.enable = true;
    };

    firejail.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.symbols-only
      jetbrains-mono
      dejavu_fonts
      noto-fonts
    ];
    fontconfig.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      # substituters = [
      #   "https://cache.nixos.org/"
      #   "https://nix-community.cachix.org"
      #   "https://hyprland.cachix.org"
      # ];
      # trusted-public-keys = [
      #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #   "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # ];

      max-jobs = "auto";
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    
    extraOptions = ''
      min-free = ${toString (512 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
      fallback = true
      connect-timeout = 5
      log-lines = 25
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
    # cudaSupport = true;
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "25.05";
}