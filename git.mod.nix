{...}: {
  personal.home_modules = [
    ({...}: {
      programs.git = {
        enable = true;
        lfs.enable = true;
        userName = "nuttyCream";
        userEmail = "issanutty@gmail.com";
        extraConfig = {
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
