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
    legcord
    bemenu
    dunst
    waybar
    zoxide
    vlc
    # archives
    zip
    unzip
    p7zip
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
    # fallback browser because zen can fucking break
    firefox

    zathura
    # just in case
    nautilus

    inputs.zen-browser.packages.x86_64-linux.default
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "nuttyCream";
    userEmail = "issanutty@gmail.com";
    extraConfig = {
      push = {autoSetupRemote = true;};
    };
    ignores = [
      "*.direnv"
    ];
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.foot = {
    enable = true;
    settings = {
      #main.font = "Maple Mono NF:size=11";
      main.font = "Geist Mono:size=11";
      cursor.color = "16181a ffffff";
      colors = {
        alpha = 0;
        foreground = "ffffff";
        regular0 = "16181a";
        regular1 = "ff6e5e";
        regular2 = "5eff6c";
        regular3 = "f1ff5e";
        regular4 = "5ea1ff";
        regular5 = "bd5eff";
        regular6 = "5ef1ff";
        regular7 = "ffffff";
        bright0 = "3c4048";
        bright1 = "ff6e5e";
        bright2 = "5eff6c";
        bright3 = "f1ff5e";
        bright4 = "5ea1ff";
        bright5 = "bd5eff";
        bright6 = "5ef1ff";
        bright7 = "ffffff";
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
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
