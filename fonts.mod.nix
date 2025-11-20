{...}: {
  personal.modules = [
    ({pkgs, ...}: {
      fonts.packages = with pkgs; [
        geist-font
        nerd-fonts.geist-mono
        ibm-plex
        maple-mono.NF-unhinted
        domine
        nerd-fonts.commit-mono
      ];
    })
  ];
}
