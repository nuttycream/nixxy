{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "j";
  home.homeDirectory = "/home/j";

  home.packages = with pkgs; [
    yazi
    vesktop
    tofi
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
    handbrake

    inputs.zen-browser.packages.x86_64-linux.default
  ];

  xdg.configFile."tofi/config".source = ./configs/tofi;

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "nuttyCream";
    userEmail = "issanutty@gmail.com";
    extraConfig = {
      push = {autoSetupRemote = true;};
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.foot = {
    enable = true;
    settings = {
      main.font = "Geist Mono:size=11";
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

  services.gammastep = {
    enable = true;
    temperature.night = 2000;
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
        pkgs.gnomeExtensions.paperwm.extensionUuid
      ];
    };
  };

  home.shellAliases = {
    g = "git";
    z = "zoxide";
    l = "ls -la";
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
