# Home Manager configuration entry point
{ config, pkgs, ... }: {
  imports = [
    ./packages.nix
    ./git.nix
    ./shell.nix
    ./kitty.nix
    ./vim.nix
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
