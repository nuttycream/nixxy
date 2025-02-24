{
pkgs,
lib,
...
}: {
  home-manager.users.j = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings.mainBar = {
        layer = "top";
        modules-left = [
          "niri/window"
        ];
        modules-right = [
          "clock"
          "battery"
        ];
      };
      style = ''
      * {
       border: none;
       border-radius: 0;
       font-family: Geist Mono;
       font-size: 12px;
       min-height: 0;
      }

      window#waybar {
       background: transparent;
       color: white;
      }

      #workspaces button {
       padding: 0 1px;
       background: transparent;
       color: white;
       border-bottom: 1px solid transparent;
      }

      #workspaces button.focused {
       border-bottom: 1px solid white;
      }

      #window {
       background: transparent;
      }

      #clock, #battery {
       padding: 0 2px;
      }

      '';
    };
  };
}
