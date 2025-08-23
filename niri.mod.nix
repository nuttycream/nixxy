{niri, ...}: {
  universal.modules = [niri.nixosModules.niri];
  personal.modules = [
    ({pkgs, ...}: {
      programs.niri.enable = true;
      nixpkgs.overlays = [niri.overlays.niri];
      programs.niri.package = pkgs.niri-stable;
      services.gnome.gnome-keyring.enable = true;
      environment.variables.NIXOS_OZONE_WL = "1";
      environment.systemPackages = with pkgs; [
        wl-clipboard
        wayland-utils
        cage
        swaybg
        xwayland-satellite
        grim
      ];
    })
  ];

  # keep the same style/layout across systems
  # we can add displays, system specific stuff
  # down below
  personal.home_modules = [
    ({config, ...}: {
      programs.niri.settings = {
        # input shit
        input.keyboard.xkb.layout = "us";
        input.keyboard.xkb.options = "compose:ralt,ctrl:nocaps";
        input.mouse.accel-speed = 0.3;
        input.mouse.accel-profile = "flat";
        input.touchpad = {
          tap = true;
          natural-scroll = true;
          middle-emulation = true;
          scroll-factor = 0.5;
        };
        cursor.hide-when-typing = true;
        cursor.hide-after-inactive-ms = 1000;

        hotkey-overlay.skip-at-startup = true;

        # ASSSS THETIC
        prefer-no-csd = true;
        layout = {
          gaps = 4;
          center-focused-column = "never";
          default-column-width.proportion = 1.0 / 2.0;
          preset-column-widths = [
            {proportion = 1.0 / 2.0;}
            {proportion = 1.0 / 3.0;}
            {proportion = 2.0 / 3.0;}
          ];
          border.enable = false;
          shadow.enable = false;
          focus-ring = {
            enable = true;
            width = 1;

            # https://css-tricks.com/old-timey-terminal-styling/
            # cant do radial
            # this is good enuff
            active.gradient = {
              angle = 180;
              from = "rgba(0, 150, 0, 0.75)";
              to = "black";
              in' = "oklch shorter hue";
              relative-to = "window";
            };
          };
        };

        # niri supports shaders,
        # lets try something in the future, ya?
        animations = {
          slowdown = 0.5;
          enable = true;
        };

        # windowing
        # ideally i want to add specific floating window rules
        # for browser popups i.e. bitwarden
        window-rules = [
          {clip-to-geometry = true;}
        ];

        spawn-at-startup = [
          {
            command = [
              "eww"
              "open"
              "sys_panel"
            ];
          }
        ];

        # binds
        binds = with config.lib.niri.actions; {
          # app launcher
          "Mod+Return".action.spawn = "foot";
          "Mod+E".action.spawn = "firefox";
          "Mod+D".action = spawn "bash" "-c" "tofi-run | xargs niri msg action spawn --";
          "Mod+W".action = spawn "eww" "open" "--toggle" "sys_panel";
          "Mod+G".action = screenshot;
          "Mod+T".action =
            spawn "bash" "-c"
            "grim -l 3 ~/Pictures/Screenshots/$(date +'%s_grim.png')";
          "Mod+Shift+E".action = quit;

          "XF86AudioRaiseVolume".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
          ];
          "XF86AudioLowerVolume".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1-"
          ];
          "XF86AudioMute".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
          "XF86AudioMicMute".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
          "XF86MonBrightnessUp".action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "+10%"
          ];
          "XF86MonBrightnessDown".action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "10%-"
          ];

          # window stuff
          "Mod+Q".action = close-window;
          "Mod+C".action = center-column;
          "Mod+F".action = maximize-column;

          "Mod+Shift+F".action = fullscreen-window;
          "Mod+Ctrl+F".action = expand-column-to-available-width;

          "Mod+V".action = toggle-window-floating;
          "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

          "Mod+R".action = switch-preset-column-width;
          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+Ctrl+R".action = reset-window-height;

          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          # window navigation
          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+L".action = move-column-right;
          "Mod+Shift+J".action = move-window-down;
          "Mod+Shift+K".action = move-window-up;
          "Mod+Ctrl+H".action = focus-monitor-left;
          "Mod+Ctrl+L".action = focus-monitor-right;
          "Mod+Ctrl+J".action = focus-monitor-down;
          "Mod+Ctrl+K".action = focus-monitor-up;
          "Mod+WheelScrollDown".cooldown-ms = 150;
          "Mod+WheelScrollUp".cooldown-ms = 150;
          "Mod+WheelScrollDown".action = focus-workspace-down;
          "Mod+WheelScrollUp".action = focus-workspace-up;

          #window workspace stuff
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
        };
      };
    })
  ];

  # desktop pc
  desky.home_modules = [
    {
      programs.niri.settings = {
        # g80sd on dp
        outputs."DP-1" = {
          # even though the g80sd is a 240hz 4k monitor
          # im fucking locked at 120
          # manual edid workaround didn't work around....
          mode.width = 3840;
          mode.height = 2160;
          mode.refresh = 239.914;
          #mode.refresh = 120.0;
          scale = 1.8;
          background-color = "#000000";
          position.x = 1280;
          position.y = 0;
        };

        outputs."HDMI-A-1" = {
          mode.width = 3840;
          mode.height = 2160;
          mode.refresh = 120.0;
          scale = 1.8;
          background-color = "#000000";
          position.x = 1280;
          position.y = 0;
        };
      };
    }
  ];

  # framework with 13in display
  lappy.home_modules = [
    {
      programs.niri.settings = {
        outputs."eDP-1" = {
          mode.width = 2256;
          mode.height = 1504;
          mode.refresh = 60.0;
          scale = 1.5;
          background-color = "#000000";
          position.x = 1280;
          position.y = 0;
        };
        outputs."DP-3" = {
          mode.width = 1920;
          mode.height = 1080;
          mode.refresh = 100.0;
          scale = 1;
          background-color = "#000000";
          position.x = 1280;
          position.y = -1080;
        };
      };
    }
  ];
}
