{
  description = "NixOS configuration with MangoWM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, mango, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux"; # change to aarch64-linux if needed
    in
    {
      nixosConfigurations.HOSTNAME = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix

          # Pulls in `programs.mango` for the system-level module
          mango.nixosModules.mango

          {
            programs.mango.enable = true;
            # programs.mango.addLoginEntry = true; # adds a display-manager login entry, on by default
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.USERNAME = import ./home.nix;
          }
        ];
      };
    };
}
