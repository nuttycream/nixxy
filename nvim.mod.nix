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

        undoFile.enable = true;

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

        autopairs.nvim-autopairs.enable = true;

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
          rust.enable = true;
          clang.enable = true;
        };

        globals = {
          mapleader = " ";
        };

        keymaps = [ 
          {
            key = "<leader>pv";
            mode = "n";
            silent = true;
            action = "<cmd>Ex<CR>";
          }
        ];
      };
    };
  };
}
