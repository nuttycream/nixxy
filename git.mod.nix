{...}: {
  personal.home_modules = [
    ({...}: {
      programs.lazygit = {
        enable = true;
        enableNushellIntegration = true;
      };

      programs.git = {
        enable = true;
        lfs.enable = true;
        signing.format = null;
        settings = {
          user = {
            name = "nuttyCream";
            email = "issanutty@gmail.com";
          };
          core = {
            editor = "nvim";
            fsmonitor = true;
          };

          push = {autoSetupRemote = true;};
          init = {defaultBranch = "main";};
        };
        ignores = [
          "*.direnv"
        ];
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };
    })
  ];
}
