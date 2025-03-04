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

  programs.niri.settings = {
  };
}
