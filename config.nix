{
  configlib = {
  	networking = {
  	  hostname = "nixos";
  	  timeZone = {
  	    region = "Europe";
  	    location = "Zurich";
  	  };
  	};
  	services = {
  	  flatpak = {
  	    enable = true;
  	  };
  	};
  	programs = {
  	  git.user = {
  	    name = "uthoughtuatehuh";
  	    email = "quanvepluxary@proton.me";
  	  };
  	  steam.enable = true;
  	  honkers-railway-launcher.enable = true;
  	  sleepy-launcher.enable = true;
  	};
  	users = {
  	  extraGroups = [ "networkmanager" "wheel" "libvirt" "wireshark" "keys" ];
  	};
  };
}
