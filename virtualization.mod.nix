{...}: {
  universal.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        distrobox
        act
      ];
      programs.virt-manager.enable = true;
      users.groups.libvirtd.members = ["j"];
      virtualisation = {
        libvirtd.enable = true;
        spiceUSBRedirection.enable = true;
        docker = {
          enable = true;
        };
      };
    })
  ];
}
