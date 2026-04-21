{nixpkgs, ...}: {
  installer = {
    system = "x86_64-linux";
    modules = [
      "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

      ({
        pkgs,
        lib,
        ...
      }: {
        networking.hostName = "installer";
        nixpkgs.hostPlatform = "x86_64-linux";

        # tools you'll actually want on the live USB
        environment.systemPackages = with pkgs; [
          git
          neovim
          curl
          wget
          # disko ships disko-install, handy for one-shot installs
          disko
        ];

        # flakes + nix command on the installer itself
        nix.settings.experimental-features = ["nix-command" "flakes"];

        # the installer image profile sets a sensible stateVersion already,
        # but pin it explicitly so rebuilds don't drift
        system.stateVersion = lib.mkDefault "25.05";
      })
    ];
  };
}
