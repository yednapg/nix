# Shell configuration
{ ... }: {
  programs.zsh = {
    enable = true;
    shellAliases = {
      switch = "sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/.config/nix";
    };
    initContent = ''
      export PATH="/opt/homebrew/bin:$PATH"
      export PYTHONDONTWRITEBYTECODE=1
      export PATH="/Library/TeX/texbin:$PATH"
      export NVM_DIR="$HOME/.nvm"
      [ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"  
      [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
    '';
  };
}
