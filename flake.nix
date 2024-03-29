{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    rnix-lsp.url = "github:nix-community/rnix-lsp";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    omegaice = {
      url = "github:omegaice/nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    omegaice,
    ...
  }: let
    username = "cvardema";
    system = "aarch64-darwin";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        self.overlays.${system}
        alejandra.overlays.default
        omegaice.overlays.default
      ];
    };
  in {
    overlays.${system} = final: prev: {};

    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home.nix
        {
          programs.home-manager.enable = true;
          home = {
            stateVersion = "22.11";
            username = "${username}";
            homeDirectory = "/Users/${username}";
          };
        }
      ];
    };
  };
}
