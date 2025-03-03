{
  description = "nixxy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    sops = {
      url = "github:Mic92/sops-nix";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    niri,
    zen-browser,
    nvf,
    ...
  } @ inputs: 
    let

      shared = [
        inputs.chaotic.nixosModules.default
        inputs.sops.nixosModules.sops
        niri.nixosModules.niri
        nvf.nixosModules.default

        ./conf.nix
        ./nvim.mod.nix
        ./shell.mod.nix

        home-manager.nixosModules.home-manager 
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.backupFileExtension = "backup";
          home-manager.users.j.imports = [
            ./home.nix
          ];
        }
      ];
    in {
      nixosConfigurations = {
        lappy = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};
          modules = shared ++ [
            ./lappy.hardware.nix
            ./niri.mod.nix
            ./waybar.mod.nix
          ];
        };
        desky = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};
          modules = shared ++ [
            ./desky.hardware.nix
            ./gnome.mod.nix
            ./gaming.mod.nix
          ];
        };
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
