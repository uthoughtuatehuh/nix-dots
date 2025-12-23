{ config, pkgs, lib, ... }:
{
  programs.firefox.policies. ExtensionSettings = {
    "sponsorBlocker@ajay.app" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
      installation_mode = "force_installed";
    };

    "jid1-MnnxcxisBPnSXQ@jetpack" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
      installation_mode = "force_installed";
    };
  
    "uBlock0@raymondhill.net" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      installation_mode = "force_installed";
    };
    
    "addon@darkreader.org" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
      installation_mode = "force_installed";
    };

    "{74145f27-f039-47ce-a470-a662b129930a}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
      installation_mode = "force_installed";
    };

    "{55f61747-c3d3-4425-97f9-dfc19a0be23c}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/spoof-timezone/latest.xpi";
      installation_mode = "force_installed";
    };

    "{6f84645f-56ef-4c8a-be7d-955bf592e65d}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/zzz-daily-checker/latest.xpi";
      installation_mode = "force_installed";
    };

    "{41033fc8-8e0e-4815-9862-cd5ec824cceb}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/honkai-star-rail-daily-checker/latest.xpi";
      installation_mode = "force_installed";
    };

    "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
      installation_mode = "force_installed";
    };

    "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
      installation_mode = "force_installed";
    };

    "jid1-ZAdIEUB7XOzOJw@jetpack" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
      installation_mode = "force_installed";
    };

    "{2b71ab6f-cc0d-4ff8-b482-470f988d5c19}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/get-tamper-monkey/latest.xpi";
      installation_mode = "force_installed";
    };

    "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
       install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
       installation_mode = "force_installed";
     };
  };
}
