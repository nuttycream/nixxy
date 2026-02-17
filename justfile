add: 
    git ls-files --others --exclude-standard | grep '\.mod\.nix$' | xargs -r git add || true

switch hostname=`hostname`: add
    {{ if hostname != `hostname` { \
        error("not the right host") \
    } else { \
        "" \
    } }}
    nixos apply .#{{hostname}} -y --local-root

update:
    nix flake update
    git add flake.lock
    git commit -m "chore: nix flake update"

fmt:
    nix fmt *
