{
  description = "Aria's system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manger.url = "github:nix-community/home-manager";
    home-manger.inputs.nixpkgs.follows = "nixpkgs";

    # CPU microcode updater
    ucodenix.url = "github:e-tho/ucodenix";

    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      nixpkgs,
      unstable,
      nix-your-shell,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ nix-your-shell.overlays.default ];
          };
          unstable = import unstable {
            inherit system;
            config.allowUnfree = true;
          };

          inherit nix-your-shell;

        };
        modules = [
          ./universal.nix
          ./hosts/nixos/configuration.nix
          ./hosts/nixos/services.nix
        ];

      };

      nixosConfigurations.low-power-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ nix-your-shell.overlays.default ];
          };
          unstable = import unstable {
            inherit system;
            config.allowUnfree = true;
          };

          inherit nix-your-shell;

        };
        modules = [
          ./universal.nix
	  ./hosts/low-power-laptop/configuration.nix
        ];

      };

    };
}
