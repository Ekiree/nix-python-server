{ inputs, config, ... }: {
    # Enable gunicorn
    systemd = {
        #gunicorn.socket
        sockets.gunicorn = {
            description = "gunicorn socket";
            socketConfig.ListenStream = [ "/run/gunicorn.sock" ];
            wantedBy = [ "sockets.target" ];
        };
        #gunicorn.service
        services= {
            gunicorn = {
                description = "gunicorn daemon";
                requires = [ "gunicorn.socket" ];
                after = [ "network.target" ];

                serviceConfig = {
                    User = "nonroot";
                    Group = "www-data";
                    WorkingDirectory = "${inputs.nix-django.packages.x86_64-linux.default}/lib/python3.11/site-packages/src";
                    EnvironmentFile = "${config.sops.secrets."env".path}";
                    # The service is configured for t2.micro with 1 vcpu. Therefore, we have 2 workers.
                    ExecStart = ''
                    ${inputs.nix-django.packages.x86_64-linux.default}/bin/gunicorn \
                    --access-logfile - \
                    --workers 2 \
                    --bind unix:/run/gunicorn.sock \
                    nixDjango.wsgi:application \
                    '';
                };

                wantedBy = [ "multi-user.target" ];
            };

            # Disable reinitialisation of AMI on restart or power cycle
            amazon-init.enable = false;
        };
    };

    # Most services will create sockets with 660 permissions.
    # This means you have to add nginx to their group.
    users.groups.gunicorn.members = [ "nginx" ];
}
