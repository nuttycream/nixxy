{ config, pkgs, ... }: 

{
  home.username = "j";
  home.homeDirectory = "/home/j";

  home.packages = with pkgs; [
    fuzzel
    dunst
    # archives
    zip
    unzip
    # utils 
    tree
    ripgrep
    fzf
    which
    # systools
    sysstat
    lm_sensors
    pciutils
    usbutils
  ];

  programs.git = {
    enable = true;
    userName = "nuttyCream";
    userEmail = "issanutty@gmail.com";
  };

  programs.fuzzel.enable = true;
  services.dunst.enable = true;

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
