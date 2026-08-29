# Git configuration
{ ... }: {
  programs.git = {
    enable = true;
    ignores = [ ".DS_Store" ];
    signing.format = "openpgp";
    settings = {
      user = {
        name = "Gaurav Pandey";
        email = "gaurav@gauravpandey.dev";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential = {
        "https://github.com".helper = [
          ""
          "!/opt/homebrew/bin/gh auth git-credential"
        ];
        "https://gist.github.com".helper = [
          ""
          "!/opt/homebrew/bin/gh auth git-credential"
        ];
      };
    };
  };
}
