{
  pkgs,
  ...
}: {

  environment.systemPackages = with pkgs; [
    mangohud
    rpi-imager
  ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
}
