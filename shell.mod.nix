{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fishPlugins.pisces
    fishPlugins.grc
    grc
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      g = "git";
      z = "zoxide";
      l = "ls -la";
    };
  };

  home-manager.users.j.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      hide_env_diff = true;
    };
  };

  users.defaultUserShell = pkgs.fish;
}
