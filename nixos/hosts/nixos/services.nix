{
  config,
  pkgs,
  unstable,
  inputs,
  ...
}:

{

  systemd.services.jellyfin-rpc = {
    enable = false;
    path = [ pkgs.jellyfin-rpc ];
    serviceConfig = {
      User = "buymymojo";
      ExecStart = "${pkgs.nix}/bin/nix run nixpkgs#jellyfin-rpc";
    };
  };

  services = {
    openssh.enable = true;
    flatpak.enable = true;
    pcscd.enable = true;

    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    ucodenix = {
      enable = true;
      #     cpuModelId = "00A20F12"; # AMD 5900X
    };

    syncthing = {
      enable = true;
      group = "users";
      user = "buymymojo";
      dataDir = "/home/buymymojo/Documents/Syncthing"; # Default folder for new synced folders
      configDir = "/home/buymymojo/Documents/.config/syncthing"; # Folder for Syncthing's settings and keys
    };

    clamav = {
      daemon.enable = true;
      daemon.settings = {
        MaxThreads = 16;
      };
      updater.enable = true;
      updater.interval = "weekly";
      updater.settings = {
        CompressLocalDatabase = true;
      };
    };

    tailscale.enable = true;

    tailscale.extraSetFlags = [
      "--advertise-exit-node"
      "--exit-node-allow-lan-access"
    ];

    # blocky = {
    #   enable = true;
    #   settings = {
    #     ports.dns = 53; # Port for incoming DNS Queries.
    #     upstreams.groups.default = [
    #       "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
    #     ];
    #     # For initially solving DoH/DoT Requests when no system Resolver is available.
    #     bootstrapDns = {
    #       upstream = "https://one.one.one.one/dns-query";
    #       ips = [ "1.1.1.1" "1.0.0.1" ];
    #     };
    #     #Enable Blocking of certian domains.
    #     blocking = {
    #       blackLists = {
    #         #Adblocking
    #         ads = [
    #           "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
    #           "https://adaway.org/hosts.txt"
    #           "https://v.firebog.net/hosts/AdguardDNS.txt"
    #           ];
    #         #Another filter for blocking adult sites
    #         adult = ["https://blocklistproject.github.io/Lists/porn.txt"];
    #         #You can add additional categories
    #       };
    #       #Configure what block categories are used
    #       clientGroupsBlock = {
    #         default = [ "ads" ];
    #         # kids-ipad = ["ads" "adult"];
    #       };
    #     };
    #     customDNS = {
    #       customTTL = "1h";
    #       mapping = {
    #         "upload.aria.coffee" = "192.168.20.2";
    #       };
    #     };
    #   };
    # };
  };

}
