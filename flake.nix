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
	environment.systemPackages = with pkgs; [ vim ];	

        homebrew = {
          enable = true;
          onActivation.cleanup = "uninstall";
          taps = [];
          brews = [ "node" ];
          casks = [
        	"alfred" "mac-mouse-fix" "warp" "jordanbaird-ice" "whatsapp" "figma" "slack"
            "discord" "1password" "mactex" "zoom" "rectangle" "visual-studio-code" "spotify"
            "eloston-chromium"
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
	    export PATH="/Library/TeX/texbin:$PATH"
	  '';
        };

        programs.neovim = {
          enable = false;
          defaultEditor = false;
          viAlias = false;
          vimAlias = false;
          vimdiffAlias = false;
          plugins = with pkgs.vimPlugins; [
          ];

          extraConfig = ''
          '';
        };
	
	programs.vim = { 
	  enable = true;
	  defaultEditor = true;
	  settings = {ignorecase = true; };
	  extraConfig = ''
                set mouse=a
                set number
                syntax on
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
