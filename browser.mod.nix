{firefox-addons, ...}: {
  personal.home_modules = [
    {
      programs.floorp = {
        enable = true;

        policies = {
          FirefoxHome = {
            AutofillAddressEnabled = false;
            AutofillCreditCardEnabled = false;
            SponsoredTopSites = false;
            SponsoredPocket = false;
            DisableTelemetry = true;
          };
        };

        profiles.j = {
          extensions = {
            force = true;
            packages = with firefox-addons.packages.x86_64-linux; [
              ublock-origin
              bitwarden
            ];
          };
        };
      };
    }
  ];
}
