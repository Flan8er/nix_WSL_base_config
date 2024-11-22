{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.git
  ];

  programs.git = {
    enable = true;
    userName = "Your Name";
    userEmail = "your.email@email.com";
  };

  # State version needs to match system state version
  home.stateVersion = "24.05";

  # Let home manager install and manage itself.
  programs.home-manager.enable = true;
}
