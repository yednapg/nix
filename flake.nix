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
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew, home-manager }:
    let
      homeconfig = { pkgs, ... }: {
        
	home.stateVersion = "23.05";
        
	programs.home-manager.enable = true;
        
	home.packages = with pkgs; [];

        home.sessionVariables = {
          EDITOR = "nvim";
        };

        programs.zsh = {
          enable = true;
          shellAliases = {
            switch = "darwin-rebuild switch --flake ~/nix";
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

	programs.neovim = {
	  enable = true;
	  plugins = with pkgs.vimPlugins; [];
	  extraConfig = ''
	    syntax on
	    set number
	    set background=dark
            colorscheme vim
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

      configuration = { pkgs, config, ... }: {
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

        environment.systemPackages = with pkgs; [vim neovim git-lfs mkalias];

        homebrew = {
          enable = true;
          onActivation.cleanup = "uninstall";
          taps = [ "homebrew/services" ];
          brews = [
            "nvm" "fish" "postgresql@17" "libpq" "rbenv" "webpack" "yarn"
            "gh" "cocoapods" "mas" "watchman"
          ];
          casks = [
            "whatsapp" "figma" "slack" "discord" "zoom" "visual-studio-code" "arc"
            "rectangle" "docker" "firefox" "google-chrome" "mactex"
            "selfcontrol" "airtable" "maccy" "appcleaner" "font-comic-shanns-mono-nerd-font"
          ];
          masApps = {
          };
        };

        system.activationScripts.applications.text = let
          env = pkgs.buildEnv {
            name = "system-applications";
            paths = config.environment.systemPackages;
            pathsToLink = "/Applications";
          };
        in
          pkgs.lib.mkForce ''
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read -r src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
          '';

        system.defaults = {
          dock.autohide = true;
          NSGlobalDomain.AppleICUForce24HourTime = true;
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
          NSGlobalDomain.KeyRepeat = 2;
          NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
          trackpad.ActuationStrength = 0;
          trackpad.Clicking = true;
        };
      };
    in
    {
      darwinConfigurations.nature = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.gauravpandey = homeconfig;
          }
          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "gauravpandey";
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
