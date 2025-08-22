{...}: {
  personal.modules = [
    ({
      pkgs,
      config,
      ...
    }: {
      #services.xserver.displayManager.startx.enable = true;

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session";
            user = "j";
          };
        };
      };

      security.pam.services.greetd.enableGnomeKeyring = true;
    })
  ];
}
