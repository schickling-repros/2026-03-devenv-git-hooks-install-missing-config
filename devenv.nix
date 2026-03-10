{ pkgs, ... }:
{
  git-hooks.enable = true;
  git-hooks.gitPackage = pkgs.git;
  git-hooks.hooks.test-hook = {
    enable = true;
    entry = "echo hook-ran";
    stages = [ "pre-commit" ];
    always_run = true;
    pass_filenames = false;
  };
}
