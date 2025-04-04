{
  config,
  pkgs,
  unstable,
  inputs,
  nix-your-shell,
  ...
}:

{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs = (
        pkgs:
        with pkgs;
        with unstable;
        [
          gamemode
          unstable.mangohud
          # additional packages...
          # e.g. some games require python3
        ]
      );
    };

    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  programs.steam.gamescopeSession.enable = true;
  programs.steam.protontricks.enable = true;
  hardware.steam-hardware.enable = true;
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
}
