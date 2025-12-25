{ config, pkgs, lib, ... }:
{
  options.configlib = {
    networking = {
      hostname = lib.mkOption {
        type = lib.types.str;
        description = "Test";
      };
    
      timeZone = {
        region = lib.mkOption {
          type = lib.types.str;
        };
        location = lib.mkOption {
          type = lib.types.str;
        };
      };
    };
  };

  config = {
    networking = {
      hostName = config.configlib.networking.hostname;
      networkmanager.enable = true;
      nftables.enable = true;
      # wireless.enable = true; # Uncomment for wpa_supplicant
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    time.timeZone = "${config.configlib.networking.timeZone.region}/${config.configlib.networking.timeZone.location}";
  
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

    services.resolved = {
      enable = true;
      dnssec = "allow-downgrade";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
    };

    systemd.services.amnezia-vpn-daemon = {
      enable = true;
      description = "AmneziaVPN Daemon";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
    
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.amnezia-vpn}/bin/AmneziaVPN-service";
        Restart = "on-failure";
        RestartSec = 5;
        User = "root";
      };
    };
  };
}
