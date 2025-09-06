{...}: {
  personal.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = with pkgs; [
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
        pixelorama
      ];
    })
  ];
}
