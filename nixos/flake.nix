{
  description = "Aria's system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manger.url = "github:nix-community/home-manager";
    home-manger.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, unstable, ... }@inputs:
    # let
    #   system = "x86_64-linux";
    #   pkgs = import nixpkgs {
    #     inherit system;
    #     config.allowUnfree = true;
    #   };
    #   unstable = import nixpkgs-unstable {
    #     inherit system;
    #     config.allowUnfree = true;
    #   };
    # in
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };

    };
}
