{...}: {
  personal.home_modules = [
    {
      programs.eww = {
        enable = true;
        configDir = ./eww;
      };
    }
  ];
}
