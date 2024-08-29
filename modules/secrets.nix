{ inputs, ... }: { 

    imports = [ 
        inputs.sops-nix.nixosModules.sops
    ];

    #Decrypt Secrets
    sops = {
        age.keyFile = "/var/run/keys/keys.txt";
        secrets.env = {
            format = "dotenv";
            sopsFile = ./.env;
        };
    };
}
