{ config, lib, pkgs, ... }:

{

  # Отключаем стандартный systemd-boot
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Включаем Lanzaboote
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Дополнительные настройки для Secure Boot
  boot.loader.efi.canTouchEfiVariables = true;

  # Автоматически генерируем ключи при первом запуске
  # system.activationScripts.securebootKeys = lib.stringAfter [ "users" ] ''
  #   if [ ! -f "/etc/secureboot/keys/db/db.key" ]; then
  #     echo "Generating Secure Boot keys..."
  #     mkdir -p /etc/secureboot/keys
  #     ${pkgs.sbctl}/bin/sbctl create-keys
  #   fi
  # '';
}
