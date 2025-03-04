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
  home-manager.users.j.xdg.configFile."niri/config.kdl".source = ./configs/niri.kdl;

}

