# Shell configuration
{ ... }: {
  programs.zsh = {
    enable = true;
    shellAliases = {
      switch = "sudo darwin-rebuild switch --flake ~/.config/nix";
    };
    initContent = ''
      export PATH="/opt/homebrew/bin/brew:$PATH"
    '';
  };
}
