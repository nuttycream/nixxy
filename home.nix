{ config, pkgs, inputs, ... }: 

{
  home.username = "j";
  home.homeDirectory = "/home/j";

  home.packages = with pkgs; [
    fuzzel
    dunst
    waybar
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

    inputs.zen-browser.packages.x86_64-linux.twilight
  ];

  programs.git = {
    enable = true;
    userName = "nuttyCream";
    userEmail = "issanutty@gmail.com";
  };

  programs.foot = {
    enable = true;
    settings = {
      colors = {
        alpha = 0;
      };
    };
  };

  programs.fuzzel.enable = true;
  services.dunst.enable = true;

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
