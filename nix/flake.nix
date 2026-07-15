{
  description = "Layered NixOS and Home Manager configuration for sco";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      determinate,
      home-manager,
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "sco";
      hostname = "mini";
      pkgs = nixpkgs.legacyPackages.${system};
      hostSettings = import ./hosts/${hostname}/settings.nix;
      specialArgs = {
        inherit inputs username hostname hostSettings;
      };
      mkHome =
        {
          name,
          user ? name,
          modules,
        }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = specialArgs // {
            username = user;
          };
          modules = modules;
        };
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          determinate.nixosModules.default
          ./hosts/${hostname}
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.${username} = import ./home.nix;
          }
        ];
      };

      homeConfigurations = {
        ${username} = mkHome {
          name = username;
          user = username;
          modules = [ ./home.nix ];
        };

        sco-sandbox = mkHome {
          name = "sco-sandbox";
          user = "sco";
          modules = [ ./home/sandbox.nix ];
        };

        root-sandbox = mkHome {
          name = "root-sandbox";
          user = "root";
          modules = [ ./home/sandbox.nix ];
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          home-manager
          git
          gh
          jq
          nix
        ];
      };
    };
}
