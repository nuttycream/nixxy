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
    }
    garbage-collection-module
  ];
}
