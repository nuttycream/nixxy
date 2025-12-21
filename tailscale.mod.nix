{...}: {
  personal.modules = [
    ({...}: {
      #networking.interfaces.tailscale0.useDHCP = false;
      services = {
        #resolved.enable = true;

        tailscale = {
          enable = true;
          #extraUpFlags = [ "--accept-routes" ];
        };
      };
    })
  ];
}
