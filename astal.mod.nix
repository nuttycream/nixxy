{
  ags,
  astal,
  ...
}: {
  personal.modules = [
    ({...}: {
      environment.systemPackages = [
        ags.packages.x86_64-linux.default
        astal.packages.x86_64-linux.default
      ];
    })
  ];
}
