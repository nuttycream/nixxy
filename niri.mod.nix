{
  pkgs,
  inputs,
  ...
}: {
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  home-manager.users.j.programs.niri.config = builtins.readFile ./configs/niri.kdl; 

}

