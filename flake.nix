{
  description = "nixxy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
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

    nvf = {
      url = "github:notashelf/nvf/v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cli.url = "github:nix-community/nixos-cli/main";
    gai.url = "github:cube-cult/gai/main";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs:
    with nixpkgs.lib; let
      # read files in curr dir
      # don't need the recursive read_dir since I
      # don't plan on having nested modules
      dir = builtins.readDir "${self}";

      params =
        inputs
        // {
          inherit inputs;
          configs = raw_configs;
          inherit merge extras;
        };

      # load the mod.nix files
      # note: git add on new mod.nix files
      read_modules =
        filterAttrs (
          name: type:
            type == "regular" && hasSuffix ".mod.nix" name
        )
        dir;

      # ripped from
      # https://github.com/sodiboo/system/blob/main/flake.nix#L96C7-L103C12
      merge = prev: this:
        {
          modules = prev.modules or [] ++ this.modules or [];
          home_modules = prev.home_modules or [] ++ this.home_modules or [];
        }
        // (optionalAttrs (prev ? system || this ? system) {
          system = prev.system or this.system;
        });

      all_modules =
        mapAttrsToList (
          name: _:
            (import "${self}/${name}") params
        )
        read_modules;

      raw_configs' =
        builtins.zipAttrsWith (
          machine:
            if machine == "extras"
            then mergeAttrsList
            else builtins.foldl' merge {}
        )
        all_modules;

      raw_configs = builtins.removeAttrs raw_configs' ["extras"];
      extras = raw_configs'.extras or {};

      configs =
        builtins.mapAttrs (
          name: config:
            nixpkgs.lib.nixosSystem {
              inherit (config) system;
              modules =
                config.modules
                ++ [
                  {
                    _module.args.home_modules = config.home_modules;
                  }
                ];
            }
        )
        raw_configs;
    in {
      nixosConfigurations = configs;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

      devShells.x86_64-linux.default = let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };

        nativeBuildInputs = with pkgs; [
          just
        ];
      in
        pkgs.mkShell {
          name = "nixxy";
          packages = nativeBuildInputs;
        };
    };
}
