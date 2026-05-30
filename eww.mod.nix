{...}: {
  personal.home_modules = [
    {
      programs.eww = {
        enable = true;
        yuckConfig = builtins.readFile ./eww/eww.yuck;
        scssConfig = builtins.readFile ./eww/eww.scss;
      };
    }
  ];
}
