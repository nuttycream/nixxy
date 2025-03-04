{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    any-nix-shell
    fishPlugins.pisces
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };

  users.defaultUserShell = pkgs.fish;

  programs.tmux = {
    enable = true;
    clock24 = true;
    shortcut = "a";
  };
}
