{
  chaotic,
  nixos-hardware,
  ...
}: let
  config = name: system: additional: {
    inherit name;
    value = {
      inherit system;
      modules =
        [
          {
            networking.hostName = name;
            nixpkgs.hostPlatform = system;
          }
        ]
        ++ additional;
    };
  };
  filesystem = fsType: path: device: options: {
    fileSystems.${path} =
      {inherit device fsType;}
      // (
        if options == null
        then {}
        else {inherit options;}
      );
  };

  fs.ext4 = filesystem "ext4";
  fs.vfat = filesystem "vfat";
  swap = device: {swapDevices = [{inherit device;}];};

  cpu = brand: {hardware.cpu.${brand}.updateMicrocode = true;};
in
  {
    universal.modules = [
      chaotic.nixosModules.default
      ({lib, ...}: {
        networking.useDHCP = lib.mkDefault true;
        time.hardwareClockInLocalTime = true;
        boot.loader.efi.canTouchEfiVariables = true;
        hardware.enableRedistributableFirmware = true;
      })
    ];

    personal.modules = [
      ({
        pkgs,
        lib,
        ...
      }: {
        boot.kernelPackages = pkgs.linuxPackages_cachyos-rc;
        chaotic.mesa-git.enable = true;

        services.scx.enable = true;
        services.scx.scheduler = "scx_lavd";
        services.fwupd.enable = true;
        hardware = {
          amdgpu.initrd.enable = lib.mkDefault true;
          graphics.enable = lib.mkDefault true;
          graphics.enable32Bit = lib.mkDefault true;
          graphics.extraPackages = with pkgs; [
            amdvlk
          ];
        };
        services.xserver.videoDrivers = ["amdgpu"];
      })
    ];
  }
  # (fs.ext4 "/location" "/dev/ice" options)
  // builtins.listToAttrs [
    # main desktop
    (config "desky" "x86_64-linux" [
      (cpu "amd")
      (fs.ext4 "/" "/dev/disk/by-uuid/300ab82a-de51-4f81-84cf-52c706b94ff3" null)
      (fs.vfat "/boot" "/dev/disk/by-uuid/5740-A46C" ["fmask=0077" "dmask=0077"])
      {
        boot.loader.grub = {
          enable = true;
          devices = ["nodev"];
          useOSProber = true;
          efiSupport = true;
        };

        boot.initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];

        boot.initrd.kernelModules = [];
        boot.kernelModules = ["kvm-amd"];
        boot.extraModulePackages = [];

        boot.binfmt.emulatedSystems = ["aarch64-linux"];
        boot.kernelParams = [
          "amd_iommu=on"
        ];
      }
    ])
    # framework 13in amd 7040
    (config "lappy" "x86_64-linux" [
      (cpu "amd")
      (fs.ext4 "/" "/dev/disk/by-uuid/529a5f7b-6d83-4a08-b950-365153f6f523" null)
      (fs.vfat "/boot" "/dev/disk/by-uuid/CB28-ADA4" ["fmask=0077" "dmask=0077"])
      {
        boot.loader.systemd-boot.enable = true;

        boot.initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "thunderbolt"
          "usb_storage"
          "sd_mod"
        ];

        boot.initrd.kernelModules = [];
        boot.kernelModules = ["kvm-amd"];
        boot.extraModulePackages = [];

        # temp amd input lag fix framework 13
        # https://community.frame.work/t/keyboard-is-laggy-on-linux-6-12-only/61736/5
        boot.kernelParams = [
          "amdgpu.dcdebugmask=0x10"
        ];
      }
      nixos-hardware.nixosModules.framework-13-7040-amd
    ])
  ]
