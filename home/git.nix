# Git configuration
{ ... }: {
  programs.git = {
    enable = true;
    userName = "Gaurav Pandey";
    userEmail = "gaurav@gauravpandey.dev";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
