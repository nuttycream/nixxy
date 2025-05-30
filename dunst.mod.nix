{...}: {
  personal.home_modules = [
    ({pkgs, ...}: {
      home.packages = with pkgs; [
        dunst
      ];

      services.dunst = {
        enable = true;
        settings = {
          global = {
            width = 300;
            height = 300;
            offset = "30x50";
            origin = "top-right";
            frame_width = 1;
            frame_color = "#009600";
            font = "IBM Plex Mono 12";
          };

          urgency_normal = {
            background = "#000000";
            foreground = "#FFFFFF";
            timeout = 10;
          };
        };
      };
    })
  ];
}
