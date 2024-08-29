{ pkgs, inputs, ... }: {

    system.activationScripts = {
        prod.text = /*bash*/ ''
            mkdir -p /srv/static
            chown -R nonroot:www-data /srv/static

            ${pkgs.sudo}/bin/sudo -u nonroot ${inputs.nix-django.packages.x86_64-linux.default}/bin/python ${inputs.nix-django.packages.x86_64-linux.default}/lib/python3.11/site-packages/nix-django/manage.py collectstatic --no-input
        '';
    };
}
