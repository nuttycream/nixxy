{
  nixos-cli,
  gai,
  ...
}: {
  universal.modules = [
    nixos-cli.nixosModules.nixos-cli
  ];

  personal.modules = [
    (
      {pkgs, ...}: {
        environment.systemPackages = [
          pkgs.nix-output-monitor
          pkgs.nvd
          pkgs.fish
          gai.packages.${pkgs.system}.default
          pkgs.openssl
        ];

        services.nixos-cli = {
          enable = true;
          config = {
            use_nvd = true;
            apply.use_nom = true;
          };
        };

        users.defaultUserShell = pkgs.nushell;
      }
    )
  ];

  personal.home_modules = [
    (
      {...}: {
        programs.nushell = {
          enable = true;
          shellAliases = {
            j = "just";
            g = "git";
            l = "ls -la";
            t = "tmux new-session -A -s main";
            ts = "tms switch";
            ff = "fastfetch";
            fg = "job unfreeze";
            bg = "job spawn";
            fit = "nix flake init -t github:akirak/flake-templates#minimal";
            fi = "nix flake init";
            c = "cargo";
          };
          settings = {
            show_banner = false;
            buffer_editor = "nvim";
          };
          extraConfig = ''
            let nixos_completer = {|spans|
              nixos _carapace nushell ...$spans | from json
            }

            let carapace_completer = {|spans: list<string>|
              carapace $spans.0 nushell ...$spans
              | from json
              | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
            }

            let fish_completer = {|spans|
              fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
                | from tsv --flexible --noheaders --no-infer
                | rename value description
                | update value {|row|
                  let value = $row.value
                    let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
                  if ($need_quote and ($value | path exists)) {
                    let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
                    $'"($expanded_path | str replace --all "\"" "\\\"")"'
                  } else {$value}
                }
            }

            let completers = {|spans|
              let expanded_alias = scope aliases
                | where name == $spans.0
                | get -o 0.expansion

              let spans = if $expanded_alias != null {
                $spans
                  | skip 1
                  | prepend ($expanded_alias | split row ' ' | take 1)
              } else {
                  $spans
              }

              match $spans.0 {
                git => $fish_completer
                nixos => $nixos_completer
                _ => $carapace_completer
              } | do $in $spans
            }

            # https://www.nushell.sh/cookbook/external_completers.html
            $env.config = {
              completions: {
                external: {
                  enable: true
                  completer: $completers
                }
              }
            }
          '';
        };

        programs.carapace = {
          enable = true;
          enableNushellIntegration = true;
        };

        programs.starship = {
          enable = true;
          settings = {
            # "$schema" = "https://starship.rs/config-schema.json";

            format = "$username$hostname$directory$git_branch$git_state$git_status$package$nix_shell$line_break$character";

            directory = {
              style = "blue";
            };

            character = {
              success_symbol = " [➜](green)";
              error_symbol = " [➜](red)";
            };

            git_branch = {
              format = "on [$branch]($style)";
              style = "purple bg:0xFCA17D";
            };

            git_status = {
              format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed )]($style)";
              style = "cyan";
              conflicted = "​";
              untracked = "​";
              modified = "​";
              staged = "​";
              renamed = "​";
              deleted = "​";
              stashed = "​≡";
            };

            git_state = {
              format = ''\([$state( $progress_current/$progress_total)]($style)\) '';
              style = "bright-black";
            };

            package = {
              format = "for [$version]($style) ";
              style = "208";
              display_private = true;
              disabled = false;
              version_format = "v$raw";
            };

            nix_shell = {
              format = "in [(\($name\))]($style) ";
              disabled = false;
              style = "blue";
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
      }
    )
  ];
}
