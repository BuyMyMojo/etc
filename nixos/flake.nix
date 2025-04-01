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

    moonlight = {
      url = "github:moonlight-mod/moonlight"; # Add `/develop` to the flake URL to use nightly.
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    shadps4-git.url = "./programs/shadps4";

    nixpkgs-gsr-ui = {
      url = "github:js6pak/nixpkgs/gpu-screen-recorder-ui/init"; # Add `/develop` to the flake URL to use nightly.
    };

    bellado.url = "github:isabelroses/bellado";

  };

  outputs =
    {
      nixpkgs,
      unstable,
      home-manager,
      nix-your-shell,
      nixpkgs-gsr-ui,
      bellado,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ nix-your-shell.overlays.default ];
      };

      unstable = import unstable {
        inherit system;
        config.allowUnfree = true;
      };

      gsr-ui = import nixpkgs-gsr-ui {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit pkgs;
          inherit unstable;

          inherit nix-your-shell;

        };
        modules = [
          ./universal.nix
          ./hosts/nixos/configuration.nix
          ./hosts/nixos/services.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.buymymojo = ./home-manager/honixos.nix;
            home-manager.extraSpecialArgs = {
              inherit unstable;
              inherit inputs;
              inherit gsr-ui;
              inherit bellado;
            };
          }
        ];

      };

      nixosConfigurations.low-power-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit pkgs;
          inherit unstable;

          inherit nix-your-shell;

        };
        modules = [
          ./universal.nix
          ./hosts/low-power-laptop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.aria = ./home-manager/low-power-laptop.nix;

            home-manager.extraSpecialArgs = {
              inherit unstable;
              inherit inputs;
              inherit bellado;
            };
          }
        ];

      };

    };
}
