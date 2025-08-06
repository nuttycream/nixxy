{...}: {
  personal.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        tmux-sessionizer
      ];
    })
  ];

  personal.home_modules = [
    ({pkgs, ...}: {
      programs.tmux = {
        enable = true;
        shortcut = "a";
        clock24 = true;
        escapeTime = 0;
        plugins = with pkgs; [
          tmuxPlugins.better-mouse-mode
        ];
        extraConfig = ''
          bind -n M-h previous-window
          bind -n M-l next-window

          bind -n M-1 select-window -t 1
          bind -n M-2 select-window -t 2
          bind -n M-3 select-window -t 3
          bind -n M-4 select-window -t 4
          bind -n M-5 select-window -t 5
          bind -n M-6 select-window -t 6
          bind -n M-7 select-window -t 7
          bind -n M-8 select-window -t 8
          bind -n M-9 select-window -t 9

          setw -g mode-style "fg=green bg=black"

          set -g pane-border-style "fg=red"
          set -g pane-active-border-style "fg=yellow"

          set -g status-position top
          set -g status-justify centre
          set -g status-style "fg=green"

          set -g status-left ""
          set -g status-left-length 10

          set -g status-right ""
          set -g status-right-length 10

          set -g message-style "fg=yellow bg=red bold"

          set-option -g mouse on
          setw -g mode-keys vi
          bind | split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"

        '';
      };
    })
  ];
}
