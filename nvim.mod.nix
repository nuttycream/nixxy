{...}: {
  personal.home_modules = [
    ({pkgs, ...}: {
      xdg.configFile."nvim/init.lua".source = ./init.lua;
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        plugins = with pkgs.vimPlugins; [
          cyberdream-nvim
          nvim-treesitter.withAllGrammars
          fzf-lua
          oil-nvim
          gitsigns-nvim
          auto-pairs
          conform-nvim
          blink-cmp
          friendly-snippets
          mini-icons
          mini-indentscope
        ];

        extraPackages = with pkgs; [
          # lsp
          lua-language-server
          nixd
          rust-analyzer

          #formatters
          stylua
          rustfmt
          alejandra
          prettierd
        ];
      };
    })
  ];
}
