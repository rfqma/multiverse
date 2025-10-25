{ ... }:

{
  programs.git = {
    enable = true;
    userName = "rfqma";
    userEmail = "abelcaster025@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.autocrlf = "input";
      push.default = "simple";
    };
  };
}
