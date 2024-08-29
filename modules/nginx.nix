{ config, ... }: {
    # Enable nginx
    services.nginx = {
        enable =  true;
        user = "nonroot";
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        resolver.addresses = config.networking.nameservers;
        sslDhparam = config.security.dhparams.params.nginx.path;
        virtualHosts = {
            "<your domain>" = {
                enableACME = true;
                forceSSL = true;
                extraConfig = ''
                   location = /favicon.ico { 
                       access_log off; 
                       log_not_found off; 
                   }

                   location / {
                       proxy_set_header Host $host;
                       proxy_set_header X-Real-IP $remote_addr;
                       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                       proxy_set_header X-Forwarded-Proto $scheme;

                       # server_name_in_redirect off;
                       # rewrite ^([^.]*[^/])$ http://13.56.251.98$1/ permanent;

                       proxy_pass http://unix:/run/gunicorn.sock;
                   }
                '';
            };
        };
    };

    # This is needed for nginx to be able to read other processes
    # directories in `/run`. Else it will fail with (13: Permission denied)
    systemd.services.nginx.serviceConfig.ProtectHome = false;
}
