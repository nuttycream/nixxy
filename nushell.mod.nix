{...}: {
  personal.modules = [
    ({pkgs, ...}: {
      users.defaultUserShell = pkgs.nushell;
    })
  ];

  personal.home_modules = [
    ({...}: {
      programs.nushell = {
        enable = true;
      };

      programs.starship = {
        enable = true;
        settings = {
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
          };
        };
      };

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        config = {
          hide_env_diff = true;
        };
      };
    })
  ];
}
