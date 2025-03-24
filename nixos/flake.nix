{
  description = "Aria's system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manger.url = "github:nix-community/home-manager";
    home-manger.inputs.nixpkgs.follows = "nixpkgs";

    # CPU microcode updater
    ucodenix.url = "github:e-tho/ucodenix";
  };

  outputs =
    { nixpkgs, unstable, ... }@inputs:
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
          };
          unstable = import unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./configuration.nix
        ];

      };

    };
}
