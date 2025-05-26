let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/";

  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };
in
  pkgs.mkShellNoCC {
    packages = with pkgs; [
      just
    ];
  }
