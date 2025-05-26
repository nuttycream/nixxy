{...}: {
  personal.modules = [
    ({
      pkgs,
      config,
      ...
    }: let
      dmcfg = config.services.displayManager;
    in {
      services.xserver.displayManager.startx.enable = true;

      services.displayManager.ly = {
        enable = true;
        settings = {
          waylandsessions = "${dmcfg.sessionData.desktops}/share/wayland-sessions";
          xsessions = "${dmcfg.sessionData.desktops}/share/xsessions";
          load = true;
          save = true;
        };
      };
    })
  ];
}
