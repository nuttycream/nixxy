build hostname=`hostname`:
    nom build .#nixosConfigurations.{{hostname}}.config.system.build.toplevel 

switch hostname=`hostname`:
    sudo nixos-rebuild switch --flake .#{{hostname}} || exit 1

fmt:
    nix fmt *
