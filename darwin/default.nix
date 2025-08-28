# Core macOS system configuration
{ pkgs, ... }: {
  # Import macOS settings and Homebrew configurations
  imports = [
    ./settings.nix
    ./homebrew.nix
  ];

  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 4;
  ids.gids.nixbld = 350;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.gauravpandey = {
    name = "gauravpandey";
    home = "/Users/gauravpandey";
  };

  programs.zsh.enable = true;

  system.primaryUser = "gauravpandey";

  environment.systemPackages = with pkgs; [ 
    vim 
    git-lfs 
    mkalias
  ];
}
