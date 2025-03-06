{...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        enableLuaLoader = true;

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

        formatter.conform-nvim = {
          enable = true;
          setupOpts = {
            format_on_save = {
              lsp_format = "fallback";
              timeout_ms = 500;
            };
          };
        };

        globals = {
          mapleader = " ";
        };

        lsp.mappings = {
          codeAction = "<leader>vca";
          goToDeclaration = "gD";
          goToDefinition = "gd";
          goToType = "gt";
          openDiagnosticFloat = "<leader>vd";
          renameSymbol = "<leader>vrn";
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
            mode = ["n" "v"];
            action = ''"+y'';
          }
          {
            key = "<leader>s";
            mode = "n";
            action = '':%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>'';
          }
        ];
      };
    };
  };
}
