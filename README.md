## Home Manager
- https://nix-community.github.io/home-manager/index.xhtml#ch-nix-flakes
-
- First, enable flakes in /etc/nixos/configuration.nix
	-
	  ```nix
	  nix.settings.experimental-features = [ "nix-command" "flakes" ];
	  ```
- From the link above:
- "Unlike the channel-based setup, home.nix will be evaluated when the flake is built, so it must be present before bootstrap of Home Manager from the flake."
	- In the home directory (~/):
		- If not already there, `mkdir .config`
		- `mkdir home-manager`
		- `touch home.nix`
		-
		  ```nix
		  { config, pkgs, ... }:
		  
		  {
		    home.username = "jdoe";
		    home.homeDirectory = "/home/jdoe";
		    
		    home.packages.git = {
		    	enable = true;
		      userName = "Casey Vaughn";
		      userEmail = "casey.vaughn9@aol.com"
		    }
		  
		    home.stateVersion = "24.05";
		  
		    programs.home-manager.enable = true;
		  }
		  ```
		- `nix run home-manager/release-24.05 -- init --switch` (yes, the spacing is correct)
		- For building and activating the flake-based configuration run: `home-manager switch` or `home-manager build`
			- Build will output a results log
		- Add `imports = [ <home-manager/nixos> ];` to the system configuration.nix file
		-
## configuration and package.nix
- Replace your existing config file in /etc/nixos/ with these

## NixOS Flakes
- In a project folder run `nix flake init` to create a template flake file
- Run `nix flake check` to compile the file and check for errors
- Run `nix flake lock` to create the lock file
- Run `nix flake update` to download any updates to the flake file
- Upon entering the project folder run `nix develop` to initialize the dev environment
-
- A good #[[Rust]] starter template:
	-
	  ```nix
	  {
	    description = "Rust flake";
	    inputs =
	      {
	        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # or whatever vers
	      };
	    
	    outputs = { self, nixpkgs, ... }@inputs:
	      let
	       system = "x86_64-linux"; # your version
	       pkgs = nixpkgs.legacyPackages.${system};    
	      in
	      {
	        devShells.${system}.default = pkgs.mkShell
	        {
	          packages = with pkgs; [ rustc cargo ]; # whatever you need
	        };
	      };
	  }
	  ```
-
-
- If pulling from GitHub and need to get the packages sha256
	- `nix-prefetch-url --unpack https://github.com/thedodd/trunk/archive/refs/tags/v0.16.0.tar.gz`
-

