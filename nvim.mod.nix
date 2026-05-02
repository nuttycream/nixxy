{...}: {
  personal.home_modules = [
    ({pkgs, ...}: {
      xdg.configFile."nvim/init.lua".source = ./init.lua;
      xdg.configFile."nvim/after/ftplugin/rust.lua".source = ./rust.lua;
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
          rustaceanvim
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
        ];
      };
    })
  ];
}
