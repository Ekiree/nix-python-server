{ pkgs, ... }: {
    # turn this to false for final prod
    # You're gonna want to have a dev env set up first
    nix = {
        enable = true;
        settings.experimental-features = [
            "nix-command"
            "flakes"
        ];
    };

    # Install packages
    environment = {
        systemPackages = with pkgs; [
            sudo
        ];
    };

    # Clean up packages after a while
    nix.gc = {
        automatic = true;
        dates = "weekly UTC";
    };
}
