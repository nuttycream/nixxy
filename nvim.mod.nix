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
          conform-nvim
          mini-nvim
          oil-nvim
          fzf-lua
        ];

        extraPackages = with pkgs; [
          # lsp
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
