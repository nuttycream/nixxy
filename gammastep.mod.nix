{...}: {
  desky.home_modules = [
    ({...}: {
      services.gammastep = {
        enable = true;
        temperature.night = 2500;
        provider = "manual";
        latitude = 38.0;
        longitude = -121.0;
      };
    })
  ];

  lappy.home_modules = [
    ({...}: {
      services.gammastep = {
        enable = false;
        temperature.night = 1500;
        provider = "manual";
        latitude = 38.0;
        longitude = -121.0;
      };
    })
  ];
}
