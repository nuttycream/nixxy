build hostname=`hostname`:
    #!/usr/bin/env bash
    git ls-files --others --exclude-standard | grep '\.mod\.nix$' | xargs -r git add || true
    nom build .#nixosConfigurations.{{hostname}}.config.system.build.toplevel 

switch hostname=`hostname`: build
    sudo nixos-rebuild switch --flake .#{{hostname}} || exit 1

fmt:
    nix fmt *
