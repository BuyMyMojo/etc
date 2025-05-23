{
  config,
  pkgs,
  unstable,
  inputs,
  nix-your-shell,
  ...
}:

{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.ucodenix.nixosModules.default
  ];

  # Use the latest linux Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = unstable.linuxPackages_xanmod_latest;
  # boot.kernelPackages = pkgs.linuxPackages_6_14;
  # boot.kernelPackages = pkgs.linuxPackages_6_13;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # networking.networkmanager.enable = true;

  i18n = {

    # Select internationalisation properties.
    defaultLocale = "C.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "C.UTF-8";
      LC_IDENTIFICATION = "C.UTF-8";
      LC_MEASUREMENT = "C.UTF-8";
      LC_MONETARY = "C.UTF-8";
      LC_NAME = "C.UTF-8";
      LC_NUMERIC = "C.UTF-8";
      LC_PAPER = "C.UTF-8";
      LC_TELEPHONE = "C.UTF-8";
      LC_TIME = "C.UTF-8";
    };

    supportedLocales = [ "all" ];
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.buymymojo = {
    isNormalUser = true;
    description = "Aria";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "docker"
      "openrazer"
      "gamemode"
      "corectrl"
      "cdrom"
    ];
    # packages = with pkgs; [
    #   # discord.override { withMoonlight = true; }
    # ];

    # packages = [
    #   # (unstable.discord.override { withMoonlight = true; })
    # ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "buymymojo";
  programs.java = {
    enable = true;
    package = pkgs.zulu23;
  };

  programs.thunderbird.enable = true;

  programs.alvr.enable = true;

  programs.noisetorch.enable = true;

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;
  # unstable.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    with pkgs;
    with unstable;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
      nixfmt-rfc-style
      pkgs.clamav

      amdgpu_top
      pkgs.mangohud

      # unstable.openrazer-daemon # Broken, enable again in a few days?

      rustc
      cargo
      go
      pnpm
      zig
      maven
      gradle
      gcc
      dotnetCorePackages.sdk_8_0_3xx
      # (pkgs.writeShellScriptBin "python" ''
      #   export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
      #   exec ${pkgs.python312}/bin/python "$@"
      # '')
      # noisetorch
      # yad
      # unzip
      # wget
      # xdotool
      # xxd
      # xorg.xwininfo

      (ffmpeg-full.override {svt-av1 = pkgs.svt-av1-psy;})
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  networking.hosts = {
    "192.168.20.2" = [
      "upload.aria.coffee"
      "aria.local"
      "dev.aria.coffee"
      "vtt.buymymojo.net"
      "home-status.buymymojo.net"
      "syncthing-home.aria.coffee"
      "localfile.aria.coffee"
      "jellyfin.buymymojo.net"
    ];
  };

  # environment.variables = {
  # };

  environment.sessionVariables = {
    # === Prefer RADV driver ===
    AMD_VULKAN_ICD = "RADV";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";

    FLAKE = "/home/buymymojo/etc/nixos/";

    MANGOHUD = "1";

    # DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "1"; # Fixes godot 4 mono's launch issues
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
