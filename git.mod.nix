{...}: {
  personal.home_modules = [
    ({...}: {
      programs.git = {
        enable = true;
        lfs.enable = true;
        settings = {
          user = {
            name = "nuttyCream";
            email = "issanutty@gmail.com";
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
