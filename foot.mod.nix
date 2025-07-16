{...}: {
  personal.home_modules = [
    {
      programs.foot = {
        enable = true;
        settings = {
          main.pad = "10x5";
          cursor.color = "16181a ffffff";
          colors = {
            alpha = 0;
            foreground = "ffffff";
            regular0 = "16181a";
            regular1 = "ff6e5e";
            regular2 = "5eff6c";
            regular3 = "f1ff5e";
            regular4 = "5ea1ff";
            regular5 = "bd5eff";
            regular6 = "5ef1ff";
            regular7 = "ffffff";
            bright0 = "3c4048";
            bright1 = "ff6e5e";
            bright2 = "5eff6c";
            bright3 = "f1ff5e";
            bright4 = "5ea1ff";
            bright5 = "bd5eff";
            bright6 = "5ef1ff";
            bright7 = "ffffff";
          };
        };
      };
    }
  ];

  desky.home_modules = [
    {
      programs.foot = {
        enable = true;
        settings = {
          main.font = "IBM Plex Mono: size=12";
        };
      };
    }
  ];

  lappy.home_modules = [
    {
      programs.foot = {
        enable = true;
        settings = {
          main.font = "IBM Plex Mono: size=11";
        };
      };
    }
  ];
}
