{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mangohud
    blender
  ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
}
