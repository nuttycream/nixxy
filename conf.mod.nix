{...}: let
  garbage-collection-module = {lib, ...}: {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    nix.optimise = {
      automatic = true;
    };
  };
in {
  universal.modules = [
    {
      system.stateVersion = "24.11";
      nixpkgs.config.allowUnfree = true;
      nix.settings = {
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["root" "j"];
      };

      time.timeZone = "America/Los_Angeles";

      programs.nix-ld = {
        enable = true;
      };

      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    }
    garbage-collection-module
  ];
}
