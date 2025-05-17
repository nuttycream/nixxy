{
  pkgs,
  inputs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.hardwareClockInLocalTime = true;

  networking.hostName = "nixxy";

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.openssh.enable = true;
  services.xserver.enable = true;
  services.libinput.enable = true;

  services.displayManager.ly.enable = true;
  #services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  services.power-profiles-daemon.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.j = {
    isNormalUser = true;
    description = "j";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = ["root" "j"];
    };
  };

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  fonts.packages = with pkgs; [
    geist-font
    nerd-fonts.geist-mono
    maple-mono.NF-unhinted
  ];

  hardware.graphics = {
    enable = true;
  };

  # services.xserver.videoDrivers = [“nvidia”];
  services.xserver.videoDrivers = ["amdgpu"];

  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    age
    networkmanagerapplet
    wl-clipboard
    wayland-utils
    xwayland-satellite
    libsecret
    cage
    swaybg
    brightnessctl
    pavucontrol
    btop
    obs-studio
    distrobox
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.xwayland.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    # insert dynamic libs
  ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["j"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?
}
