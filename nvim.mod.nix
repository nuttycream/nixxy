{nvf, ...}: {
  personal.modules = [
    nvf.nixosModules.default
    ({pkgs, ...}: {
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

            extraPlugins = {
              cyberdream = {
                package = pkgs.vimPlugins.cyberdream-nvim;
                setup = ''
                  require('cyberdream').setup {
                    variant = "dark",
                    transparent = true,
                    italic_comments = true,
                    extensions = {
                      fzflua = true,
                      mini = true,
                      whichkey = true
                    }
                  }
                  vim.cmd('colorscheme cyberdream')
                '';
              };
            };

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

            spellcheck = {
              enable = true;
              programmingWordlist.enable = true;
              ignoredFiletypes = [
                "rust"
                "nix"
                "c"
                "go"
                "yuck"
              ];
            };

            presence.neocord = {
              enable = true;
            };

            mini = {
              icons.enable = true;
              indentscope.enable = true;
            };

            autopairs.nvim-autopairs.enable = true;
            fzf-lua = {
              enable = true;
              setupOpts.winopts.border = "none";
            };

            git = {
              enable = true;
              git-conflict.enable = false;
            };

            binds.hardtime-nvim = {
              enable = false;
              setupOpts = {
                max_count = 10;
                disable_mouse = false;
              };
            };

            binds.whichKey = {
              enable = true;
            };

            treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
              regex
              kdl
              yuck
            ];

            languages = {
              # is this depcretaed or wut
              # enableLSP = true;

              nix = {
                enable = true;
                format.enable = true;
                lsp.enable = true;
                lsp.server = "nixd";
              };

              rust = {
                enable = true;
                lsp.enable = true;
                format.enable = true;
                treesitter.enable = true;
                lsp.opts = ''
                  ['rust-analyzer'] = {
                    cargo = {allFeature = true},
                    checkOnSave = true,
                    procMacro = {
                      enable = true,
                    },
                  },
                '';
              };

              clang = {
                enable = true;
                lsp.enable = true;
                treesitter.enable = true;
                cHeader = true;
              };

              lua = {
                enable = true;
                format.enable = true;
                lsp.enable = true;
                lsp.lazydev.enable = true;
              };

              zig = {
                enable = true;
                lsp.enable = true;
              };

              go = {
                enable = true;
                lsp.enable = true;
                format = {
                  enable = true;
                  type = "gofumpt";
                };
                treesitter.enable = true;
              };

              html = {
                enable = true;
                treesitter.enable = true;
                treesitter.autotagHtml = true;
              };

              markdown = {
                enable = true;
                format.enable = true;
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

            utility = {
              oil-nvim = {
                enable = true;
                setupOpts = {
                  skip_confirm_for_simple_edits = true;
                  columns = [
                    "icon"
                    "size"
                  ];
                  view_options = {
                    show_hidden = true;
                  };
                };
              };

              outline.aerial-nvim = {
                enable = true;
                mappings.toggle = "<leader>pa";
              };
            };

            globals = {
              editorconfig = true;
              mapleader = " ";
            };

            lsp = {
              enable = true;
              formatOnSave = true;
              trouble = {
                enable = true;
                mappings = {
                  documentDiagnostics = "<leader>xx";
                };
              };

              mappings = {
                codeAction = "<leader>vca";
                goToDeclaration = "gD";
                goToDefinition = "gd";
                goToType = "gt";
                openDiagnosticFloat = "<leader>vd";
                renameSymbol = "<leader>vrn";
              };
            };

            keymaps = [
              {
                key = "<leader>pv";
                mode = "n";
                action = "<cmd>Oil<CR>";
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
    })
  ];
}
