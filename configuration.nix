{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
    <home-manager/nixos>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # Import packages
  environment.systemPackages = with pkgs; import ./packages.nix {
    inherit pkgs;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow working from flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Random settings
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.firefox.enable = true;

  users.users.eve.isNormalUser = true;
  home-manager.users.eve = { pkgs, ... }: {
    home.packages = [ pkgs.atool pkgs.httpie ];
    programs.bash.enable = true;
  };

  system.stateVersion = "24.05";
}
