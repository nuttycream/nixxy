{
  firefox-addons,
  firefox-nightly,
  ...
}: {
  # get the nightly version
  personal.modules = [
    ({pkgs, ...}: {
      environment.systemPackages = [
        firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin
      ];
    })
  ];

  personal.home_modules = [
    ({...}: {
      programs.firefox = {
        enable = true;
        profiles = {
          "j" = {
            id = 0;
            isDefault = true;

            search.engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                definedAliases = ["@np"];
              };
              "Nix Options" = {
                definedAliases = ["@no"];
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };
            };
          };
        };
      };
    })
  ];
}
