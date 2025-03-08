{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mangohud
  ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
}
