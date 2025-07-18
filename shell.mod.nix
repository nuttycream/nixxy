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
        shellAliases = {
          j = "just";
          g = "git";
          l = "ls -la";
          ff = "fastfetch";
          fg = "job unfreeze";
          bg = "job spawn";
          fi = "nix flake init -t github:akirak/flake-templates#minimal";
        };
        settings = {
          show_banner = false;
          buffer_editor = "nvim";
        };
      };

      programs.starship = {
        enable = true;
        settings = {
          character = {
            success_symbol = " [➜](bold green)";
            error_symbol = " [➜](bold red)";
          };
        };
      };

      programs.tmux = {
        enable = true;
        clock24 = true;
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
