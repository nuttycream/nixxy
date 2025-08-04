add: 
    git ls-files --others --exclude-standard | grep '\.mod\.nix$' | xargs -r git add || true

switch hostname=`hostname`: add
    nixos apply .#{{hostname}} 

update:
    nix flake update
    git add flake.lock
    git commit -m "chore: nix flake update"

fmt:
    nix fmt *
