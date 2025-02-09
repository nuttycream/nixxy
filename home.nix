{ config, pkgs, inputs, ... }: 

{
  home.username = "j";
  home.homeDirectory = "/home/j";

  home.packages = with pkgs; [
    fuzzel
    dunst
    waybar
    zoxide
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

    inputs.zen-browser.packages.x86_64-linux.default
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

  programs.bash.enable = true;

  programs.fuzzel.enable = true;
  services.dunst.enable = true;

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.waybar = {
    enable = true;
  };

  services.gammastep = {
    enable = true;
    temperature.night = 1000;
    provider = "manual";
    latitude = 38.0;
    longitude = -121.0;
  };

  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        pkgs.gnomeExtensions.hide-top-bar.extensionUuid
        pkgs.gnomeExtensions.vitals.extensionUuid
      ];
    };
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
