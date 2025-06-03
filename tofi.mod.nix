{...}: {
  personal.home_modules = [
    {
      programs.tofi = {
        enable = true;
        settings = {
          font = "IBM Plex Serif";
          height = "100%";
          width = "100%";
          background-color = "#00000095";
          border-width = 0;
          num-results = 10;
          outline-width = 0;
          padding-left = "35%";
          padding-top = "35%";
          result-spacing = 5;
        };
      };
    }
  ];
}
