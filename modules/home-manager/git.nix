{
  lib,
  config,
  ...
}: {
  options.git.enable = lib.mkEnableOption "enables git home-manager module";
  options.git.email = lib.mkOption {
    default = "sean.f.t.engelhardt@gmail.com";
    type = lib.types.str;
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      settings = {
        alias = {
          ca = "commit --amend --date=\"now\"";
          ci = "commit -m";
          cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|dev' | xargs -n 1 git branch -d";
          clean-remote = "!git push origin --delete $(git branch -r --merged origin/master |  grep origin/ | egrep -v '>|master|develop' | cut -d/ -f2)";
          lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
          lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
          lg = "!git lg1";
        };
        user = {
          name = "Sean Engelhardt";
          email = config.git.email;
        };
        core = {
          commentchar = ";";
          editor = "nvim";
        };
        color = {
          ui = "auto";
        };
        push = {
          autoSetupRemote = true;
          default = "current";
        };
        pull = {
          rebase = true;
        };
        init.defaultBranch = "master";
      };
    };
  };
}
