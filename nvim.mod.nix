{
  pkgs,
  lib,
  ...
}: {
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
        presence.neocord.enable = true;
        presence.neocord.setupOpts = {
          show_time = false; # :^)
          global_timer = true;
        };
        fzf-lua.enable = true;

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix = {
            enable = true;
            lsp.enable = true;
            lsp.server = "nixd";
          };

          rust.enable = true;
          clang.enable = true;
        };

        autocomplete.blink-cmp = {
          enable = true;
        };

        globals = {
          mapleader = " ";
        };

        keymaps = [
          {
            key = "<leader>pv";
            mode = "n";
            action = "<cmd>Ex<CR>";
          }
          {
            key = "<leader>pf";
            mode = "n";
            action = ''require("fzf-lua").files'';
            lua = true;
          }
          {
            key = "<leader>ps";
            mode = "n";
            action = ''require("fzf-lua").live_grep'';
            lua = true;
          }
          {
            key = "<leader>y";
            mode = "n";
            action = ''[["+y]]'';
            lua = true;
          }
        ];
      };
    };
  };
}
