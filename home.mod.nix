{home-manager, ...}: {
  universal.modules = [
    home-manager.nixosModules.home-manager
    ({config, ...}: {
      users.users.j = {
        isNormalUser = true;
        description = "j";
        extraGroups = [
          "networkmanager"
          "wheel"
          "video"
          "max"
        ];
      };

      home-manager.backupFileExtension = "backup";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.j = {
        home.username = "j";
        home.homeDirectory = "/home/j";
        home.stateVersion = "24.11";
        imports = config._module.args.home_modules;
      };
    })
  ];

  # I have no idea what the fuck this does, but it looks
  # useful since systemd tends to be funky for me
  # from a glance it seems to restart user systemd services

  personal.home_modules = [
    ({
      lib,
      config,
      ...
    }: {
      options.systemd-fuckery = {
        auto-restart = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
        };
      };

      config = {
        home.activation.restartSystemdFuckery = let
          ensureRuntimeDir = "XDG_RUNTIME_DIR=\${XDG_RUNTIME_DIR:-/run/user/$(id -u)}";

          systemctl = "env ${ensureRuntimeDir} ${config.systemd.user.systemctlPath}";

          each = f: builtins.concatStringsSep "\n" (map f config.systemd-fuckery.auto-restart);
        in
          lib.mkIf (config.systemd-fuckery.auto-restart != []) (
            lib.hm.dag.entryAfter ["reloadSystemd"] ''
              systemdStatus=$(${systemctl} --user is-system-running 2>&1 || true)

              if [[ $systemdStatus == 'running' || $systemdStatus == 'degraded' ]]; then
                ${each (unit: ''
                run ${systemctl} --user try-restart ${unit}.service
              '')}
              else
                echo "User systemd daemon not running. Skipping reload."
              fi
            ''
          );
      };
    })
  ];
}
