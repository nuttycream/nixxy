{
  description = "c dev template based off of the-nix-way/dev-templates";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
  };

  outputs = { self, nixpkgs }: 
    let
      systems = [ "x86_64-linux" "aarch64-linux"];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs systems (
        system: f { pkgs = import nixpkgs { inherit system; };
        });
    in {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell.override {
          # Override stdenv in order to change compiler:
          # stdenv = pkgs.clangStdenv;
        }
          {
            packages = with pkgs; [
              clang-tools
              cmake
              gdb
            ];
          };
      });
    };
}
