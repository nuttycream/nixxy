{...}: {
  universal.modules = [
    ({...}: {
      networking.networkmanager = {
        enable = true;
        wifi.powersave = true;
      };

      security.rtkit.enable = true;

      # scan
      hardware.sane.enable = true;

      services = {
        blueman.enable = true;
        openssh.enable = true;
        xserver.enable = true;
        libinput.enable = true;

        printing.enable = true;
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };

        pulseaudio.enable = false;
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
        };
      };
    })
  ];

  lappy.modules = [
    {
      services.power-profiles-daemon.enable = true;
    }
  ];
}
