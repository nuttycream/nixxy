{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    xwayland-satellite

    niri
  ];

  programs.xwayland.enable = true;
  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  services.gnome.gnome-keyring.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  home-manager.users.j.xdg.configFile."niri/config.kdl".source = ./niri.kdl;
}
