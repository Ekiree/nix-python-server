{modulesPath, ...}: {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
    ./modules/gunicorn.nix
    ./modules/networking.nix
    ./modules/nginx.nix
    ./modules/nixos.nix
    ./modules/secrets.nix
    ./modules/security.nix
    ./modules/users.nix
  ];

  system.stateVersion = "24.05";
}
