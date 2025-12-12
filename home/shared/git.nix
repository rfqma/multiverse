{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "rfqma";
        email = "abelcaster025@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      core.autocrlf = "input";
      push.default = "simple";
    };
  };
}
