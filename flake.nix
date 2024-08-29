{
    description = "Flake for deploying applications configured with nix-Django";

    inputs = {
        # Nix Packages
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        flake-utils.url = "github:numtide/flake-utils";

        #sops for secret management
        sops-nix.url = "github:Mic92/sops-nix";
        
        # nix-django App
        nix-django = {
            url = "github:Ekiree/nix-django";
        };
    };

    outputs = { nixpkgs, ... }@inputs: {
        nixosConfigurations = {
            prod = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./configuration.nix
                ];
            };
        };
    };
}
