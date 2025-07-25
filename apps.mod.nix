{...}: {
  personal.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        zoom-us
        nautilus
        zathura
        vesktop
        pandoc
        yazi
        slack
      ];
    })
  ];

  desky.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        blender
        gimp3
        obs-studio
        inkscape
      ];
    })
  ];
}
