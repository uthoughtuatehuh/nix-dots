<h1 align="left"> About</h1>

<img src="https://github.com/user-attachments/assets/4f15d2ae-caf8-4f4d-8aa8-87daa8003280" alt="image" align="right" width="500px">

</br>

 - OS: [**`NixOS`**](https://nixos.org/)
 - WM: [**`Hyprland`**](https://hyprland.org)
 - Bar: [**`Waybar`**](https://github.com/Alexays/Waybar) / [**`Caelestia`**](https://github.com/caelestia-dots/shell) (Custom QML-based bar)
 - Terminal: [**`Kitty`**](https://github.com/kovidgoyal/kitty)
 - App Launcher: [**`Rofi`**](https://github.com/davatorium/rofi)
 - Notify Daemon: [**`Dunst`**](https://github.com/dunst-project/dunst)
 - Shell: [**`Fish`**](https://github.com/fish-shell/fish-shell)
 - Display Manager: [**`Ly`**](https://github.com/fairyglade/ly)
 
</br>

## 🎥 Demonstration
Check out the profile switching in action: [**YouTube Video**](https://youtu.be/Pp6Z5P39hMg) *(link to be added)*

## 🎯 Profile System
This configuration features a modular profile system that allows switching between different desktop environments:

- **`waybar`** - Traditional setup with Waybar, Rofi, and Dunst
- **`caelestia`** - Experimental QML-based desktop with custom compositor integration  
- **`shared`** - Common configurations applied to all profiles (Fish shell, Kitty terminal, etc.)

### Profile Selection
Profiles are enabled in `home.nix` using a simple list:
```nix
let
  enabledProfiles = [
    "caelestia"  # Currently active profile
    # "waybar"   # Commented out - inactive
    "shared"     # Always enabled for base configs
  ];
in {
  # Configuration...
}
```

Each profile includes:
- **Systemd services** for automatic startup management
- **Custom configurations** for all components  
- **Package sets** specific to the profile
- **Wallpaper and theme management**

## Installation
Copy the files from repo to /etc/nixos, but:

- Modify `modules/bootloader.nix` for yourself, if this is not done, there will be problems with the launch
- Modify `modules/filesystems.nix` for yourself, this config contains information about mounting a disk by UID in /mnt/d/
- If you have an `nvidia` graphics card and the drivers are not installed correctly, change `modules/hardware.nix` -> `hardware.nvidia.open.false` -> `true`

## Additional information
- Instead of the usual `sudo`, `doas` is used here
- This nixos setting uses the `unstable` nixos channel
- If you want to install some packages from nixos pkgs, I `recommend` dividing them into `system (modules/packages.nix)` and `user (home/packages.nix) packages`
- If you want to change the configs of these programs: `dunst, fish, hyprland, kitty or rofi`, then you need to do it in `home/configs/`, and then write `nix-rebuild` (fish allias), or `doas nixos-rebuild switch`
