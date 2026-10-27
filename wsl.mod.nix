{nixos-wsl, ...}: {
  wissy = {
    system = "x86_64-linux";
    modules = [
      nixos-wsl.nixosModules.default
      ({lib, ...}: {
        networking.hostName = "wissy";
        nixpkgs.hostPlatform = "x86_64-linux";

        wsl.enable = true;
        wsl.defaultUser = "j";

        system.stateVersion = lib.mkForce "26.05";
        #system.stateVersion = lib.mkForce "26.05";
      })
    ];
  };
}
