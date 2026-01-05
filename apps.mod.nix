{...}: {
  personal.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        nautilus
        zathura
        #vesktop
        legcord
        pandoc
        yazi
        slack
        asciinema
        asciinema-agg
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
