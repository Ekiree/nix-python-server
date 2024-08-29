{...}: {
  # Activate firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
  };

  # Enable ssh
  services.openssh = {
    enable = true;
    openFirewall = false; # SSH is done via SSM proxy
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = "nonroot";
      PermitRootLogin = "no";
    };
  };

  services.amazon-ssm-agent.enable = true;

  ## Enable BBR module
  boot.kernelModules = ["tcp_bbr"];
}
