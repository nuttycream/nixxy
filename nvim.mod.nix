{...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        enableLuaLoader = true;

        luaConfigPre = ''
          vim.diagnostic.config({
            virtual_text = { current_line = true }
          })
        '';

        extraLuaFiles = [
          #./nvim-plugin/lua/hl-buffer.lua
        ];

        viAlias = true;
        vimAlias = true;

        undoFile.enable = true;

        options = {
          tabstop = 4;
          softtabstop = 4;
          shiftwidth = 4;
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
        fzf-lua = {
          enable = true;
          setupOpts.winopts.border = "none";
        };

        git = {
          enable = true;
          git-conflict.enable = false;
        };

        treesitter = {
          enable = true;
        };

        languages = {
          enableLSP = true;
          enableTreesitter = true;
          enableFormat = true;

          nix = {
            enable = true;
            lsp.enable = true;
            lsp.server = "nixd";
          };

          rust = {
            enable = true;
            lsp.enable = true;
          };

          clang = {
            enable = true;
            lsp.enable = true;
          };

          lua = {
            enable = true;
            lsp.enable = true;
            lsp.lazydev.enable = true;
          };

          zig = {
            enable = true;
            lsp.enable = true;
          };

          html = {
            enable = true;
            treesitter.enable = true;
            treesitter.autotagHtml = true;
          };

          markdown = {
            enable = true;
            extensions.render-markdown-nvim.enable = true;
          };

          ts = {
            enable = true;
            treesitter.enable = true;
          };
        };

        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };

        comments.comment-nvim.enable = true;

        formatter.conform-nvim = {
          enable = true;
          setupOpts = {
            formatters_by_ft = {
              rust = [
                "rustfmt"
              ];
            };
            format_on_save = {
              lsp_format = "fallback";
              timeout_ms = 250;
            };
          };
        };

        globals = {
          editorconfig = true;
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
          {
            key = "<C-u>";
            mode = "n";
            action = ''<C-u>zz'';
          }
        ];
      };
    };
  };
}
