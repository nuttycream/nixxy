{
  pkgs, 
  lib,
  ...
}:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        options = {
          tabstop = 2;
          softtabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          smartindent = true;
        };

        theme = {
          enable = true;
          name = "oxocarbon";
          style = "dark";
          transparent = true;
        };


        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
        };
      };
    };
  };
}
