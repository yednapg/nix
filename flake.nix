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
        environment.systemPackages = [ 
                    
        ];
        homebrew = {
          enable = true;
          onActivation.cleanup = "uninstall";
          taps = [ ];
          brews = [ "python3" "node" ];
          casks = [ "figma" "alacritty" "slack" "discord" "zoom" "rectangle" "visual-studio-code" "google-chrome" "spotify" "firefox@developer-edition" ];
        };
   	
	# macOS settings
        system.defaults.dock.autohide = true;
      };

      homeconfig = { pkgs, ... }: {
        home.stateVersion = "23.05";
        programs.home-manager.enable = true;
        
	# home-manager packages
        home.packages = with pkgs; [
	 ];

        home.sessionVariables = {
          EDITOR = "vim";
        };

        programs.zsh = {
          enable = true;
          shellAliases = {
            switch = "darwin-rebuild switch --flake ~/.config/nix";
          };
        };
        
        programs.zsh.dotDir = ".config/zsh";  
        programs.zsh.initExtra = ''
          # Powerlevel10k Zsh theme  
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme  
          test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh  
        '';

        programs.neovim = {
          enable = true;
          defaultEditor = false;
          viAlias = false;
          vimAlias = false;
          vimdiffAlias = false;
          plugins = with pkgs.vimPlugins; [
          ];
          extraLuaConfig = ''
            vim.o.termguicolors = true
          '';
        };

        programs.alacritty = {
          enable = true;
          settings = {
            font.size = 18;
            window = {
              padding.x = 10;
              padding.y = 10;
              decorations = "buttonless";
            };
          };
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
