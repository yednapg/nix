{
  description = "My Nix configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
    let
      configuration = { pkgs, ... }: {
        services.nix-daemon.enable = true;
        nix.settings.experimental-features = "nix-command flakes";
        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 4;
        nixpkgs.hostPlatform = "aarch64-darwin";
        users.users.gauravpandey = {
          name = "gauravpandey";
          home = "/Users/gauravpandey";
        };
        security.pam.enableSudoTouchIdAuth = true;
        programs.zsh.enable = true;

        # nix-darwin packages
	environment.systemPackages = with pkgs; [ vim git-lfs ];	

        homebrew = {
          enable = true;
          onActivation.cleanup = "uninstall";
          taps = [  "homebrew/services" ];
          brews = [ "nvm" "fish" "postgresql@17" "libpq" "rbenv" "webpack" "yarn" "gh" "cocoapods"];
          casks = [
        	 "whatsapp" "figma" "slack" "discord" "zoom" "visual-studio-code" "1password" "1password-cli" "mactex" "warp" "firefox@developer-edition" "rectangle"  "eloston-chromium" "docker"  "selfcontrol" "jordanbaird-ice" "alfred" "maccy" "kitty"
          ];
        };

        # macOS settings
        system.defaults.dock.autohide = true;
      };

      homeconfig = { pkgs, ... }: {
        home.stateVersion = "23.05";
        programs.home-manager.enable = true;

        # home-manager packages
        home.packages = with pkgs; [];

        home.sessionVariables = {
          EDITOR = "vim";
        };

        programs.zsh = {
          enable = true;
          shellAliases = {
            switch = "darwin-rebuild switch --flake ~/.config/nix";
          };
		
	  initExtra = ''
	    export PATH="/opt/homebrew/bin/brew:$PATH"
            export PATH="/Library/TeX/texbin:$PATH"
            export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
            export PATH=./node_modules/.bin:$PATH
            export NVM_DIR="/opt/homebrew/Cellar/nvm/0.40.1" && alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"
            export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
            export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
            export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
	  '';
        };

	programs.vim = { 
	  enable = true;
	  defaultEditor = true;
	  settings = {ignorecase = true; };
	  extraConfig = ''
              syntax on
              set number
              set mouse=a
             
          '';
        };

        programs.git = {
          enable = true;
          userName = "Gaurav Pandey";
          userEmail = "hi@pandeygaurav.com";
          ignores = [ ".DS_Store" ];
          extraConfig = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
            };
          };
      };
    in
    {
      darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.gauravpandey = homeconfig;
          }
        ];
      };
    };
}
