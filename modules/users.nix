{ inputs, ... }: {

    users.groups.www-data = {};
    users.users.nonroot = {
        isSystemUser = true;
        group = "www-data";
        extraGroups = [ "nginx" ]; 
        openssh.authorizedKeys.keys = [ 
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHi147srccRTMnUiFn9kZYaoS6z29UUkCHpNBqPZFII/ ekiree" 
        ];
        packages = [
            #Sets python interpreter with poetry from nix-django
            inputs.nix-django.packages.x86_64-linux.default
        ];
    };
}
