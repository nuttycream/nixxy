{...}: {
  personal.home_modules = [
    ({pkgs, ...}: {
      xdg.configFile."nvim/init.lua".source = ./init.lua;
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        withRuby = false;
        withPython3 = false;
        plugins = with pkgs.vimPlugins; [
          cyberdream-nvim
          nvim-treesitter.withAllGrammars
          conform-nvim
          mini-nvim
          blink-cmp
          oil-nvim
          fzf-lua
        ];

        extraPackages = with pkgs; [
          # lsp
          nixd
          rust-analyzer
          tinymist
          gopls
          vscode-langservers-extracted

          #formatters
          stylua
          rustfmt
          alejandra
          prettierd
          djlint
        ];
      };
    })
  ];
}
