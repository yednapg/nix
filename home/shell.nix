# Shell configuration
{ ... }: {
  programs.zsh = {
    enable = true;
    # nix-darwin already initializes completion in /etc/zshrc. Running it
    # again with Home Manager's fpath rebuilds the shared cache twice.
    enableCompletion = false;
    envExtra = ''
      # /etc/zshrc calls compinit before .zshrc. Give it a cache for this
      # Zsh version and completion path, so app and inherited environments
      # cannot invalidate one another's cache on every launch.
      if [[ -o interactive ]]; then
        compinit() {
          unfunction compinit
          autoload -Uz compinit
          local _comp_key _comp_cache _comp_result
          _comp_key=$(print -rl -- $fpath | /usr/bin/cksum)
          _comp_cache="$HOME/.cache/zsh/zcompdump-$ZSH_VERSION-''${_comp_key%% *}"
          if [[ ! -d "$HOME/.cache/zsh" ]]; then
            command mkdir -p "$HOME/.cache/zsh" || return $?
          fi
          compinit -d "$_comp_cache" "$@"
          _comp_result=$?
          if (( _comp_result == 0 )) && [[ -f "$_comp_cache" &&
              ( ! -f "$_comp_cache.zwc" || "$_comp_cache" -nt "$_comp_cache.zwc" ) ]]; then
            zcompile "$_comp_cache"
          fi
          return $_comp_result
        }
      fi
    '';
    shellAliases = {
      switch = "sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/.config/nix";
    };
    initContent = ''
      export PATH="$HOME/.local/bin:$PATH"
      export PATH="/opt/homebrew/bin:$PATH"
      export PYTHONDONTWRITEBYTECODE=1
      export PATH="/Library/TeX/texbin:$PATH"
      export NVM_DIR="$HOME/.nvm"

      # Make the installed default Node available to scripts without starting
      # NVM. Full NVM initialization is deferred until a Node command is used.
      if [[ -r "$NVM_DIR/alias/default" ]]; then
        _nvm_default=$(<"$NVM_DIR/alias/default")
        _nvm_default_bin="$NVM_DIR/versions/node/v''${_nvm_default#v}/bin"
        [[ -x "$_nvm_default_bin/node" ]] && path=("$_nvm_default_bin" $path)
        unset _nvm_default _nvm_default_bin
      fi

      _load_nvm() {
        unfunction nvm node npm npx corepack
        if [[ ! -s /opt/homebrew/opt/nvm/nvm.sh ]]; then
          print -u2 -- "NVM is missing: /opt/homebrew/opt/nvm/nvm.sh"
          return 127
        fi
        source /opt/homebrew/opt/nvm/nvm.sh || return $?
        if [[ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ]]; then
          source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm
        fi
        return 0
      }
      nvm() { _load_nvm && nvm "$@"; }
      node() { _load_nvm && node "$@"; }
      npm() { _load_nvm && npm "$@"; }
      npx() { _load_nvm && npx "$@"; }
      corepack() { _load_nvm && corepack "$@"; }
    '';
  };
}
