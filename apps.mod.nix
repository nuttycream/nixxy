{...}: {
  personal.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        zoom-us
        nautilus
        zathura
        legcord
        pandoc
        yazi
      ];
    })
  ];

  desky.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        blender
        gimp3
        obs-studio
      ];
    })
  ];
}
