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
    '';
    shellAliases = {
      g = "git";
      z = "zoxide";
      l = "ls -la";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  users.defaultUserShell = pkgs.fish;
}
