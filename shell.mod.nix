{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    any-nix-shell
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

  users.defaultUserShell = pkgs.fish;
}
