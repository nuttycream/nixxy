{nixos-cli, ...}: {
  universal.modules = [nixos-cli.nixosModules.nixos-cli];

  personal.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = [
        pkgs.nix-output-monitor
        pkgs.nvd
      ];

      services.nixos-cli = {
        enable = true;
        config = {
          use_nvd = true;
          apply.use_nom = true;
        };
      };

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
          t = "tmux new-session -A -s main";
          ff = "fastfetch";
          fg = "job unfreeze";
          bg = "job spawn";
          fit = "nix flake init -t github:akirak/flake-templates#minimal";
          fi = "nix flake init";
        };
        settings = {
          show_banner = false;
          buffer_editor = "nvim";
        };
        extraConfig = ''
          let nixos_completer = {|spans|
            nixos _carapace nushell ...$spans | from json
          }

          # https://www.nushell.sh/cookbook/external_completers.html
          $env.config = {
            completions: {
              external: {
                enable: true
                completer: $nixos_completer
              }
            }
          }
        '';
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
