{...}: {
  universal.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        wget
        age
        networkmanagerapplet
        libsecret
        brightnessctl
        pavucontrol
        btop
        tree
        zip
        unzip
        p7zip
        fzf
        which
        sysstat
        lm_sensors
        pciutils
        usbutils
        handbrake
        ripgrep
        fastfetch
        harper
        jq
      ];
    })
  ];
}
