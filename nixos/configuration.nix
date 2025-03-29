# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  unstable,
  inputs,
  nix-your-shell,
  ...
}:

# let
#   berkeley-mono-typeface = pkgs.callPackage ./packages/berkeley-mono-typeface.nix;
# in

{
  nixpkgs.overlays = [
    nix-your-shell.overlays.default
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

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

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      nerdfonts
      # berkeley-mono-typeface
    ];
  };

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

  programs.firefox.enable = true;
  programs.thunderbird.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      nix-your-shell fish | source
    '';
  };


  programs.gpu-screen-recorder = {
    enable = true;
    package = unstable.gpu-screen-recorder;
  };

  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs = (pkgs: with pkgs; [
        gamemode
        mangohud
        # additional packages...
        # e.g. some games require python3
      ]);
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

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

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
      fzf
      nixfmt-rfc-style
      unstable.dwarfs
      unrar
      mpv
      unstable.waypipe
      unstable.nix-your-shell

      amdgpu_top
      # unstable.mangohud

      unstable.svt-av1-psy
      unstable.ffmpeg-full
      unstable.ab-av1
      unstable.whisper-cpp-vulkan

      vscode.fhs # .fhs version will be more compatable even if slightly less nix flavoured

      openrazer-daemon

      # === nix related ===
      comma
      nh
      # === nix related ===

      rustc
      cargo
      go
      pnpm
      zig
      maven
      gradle
      gcc
      dotnetCorePackages.sdk_8_0_3xx

      # noisetorch
      # yad
      # unzip
      # wget
      # xdotool
      # xxd
      # xorg.xwininfo
    ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # === Godot ===
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXext
    xorg.libXrandr
    xorg.libXrender
    xorg.libX11
    xorg.libXi
    libGL
    wayland
    wayland-scanner
    vulkan-loader
    fontconfig
    libxkbcommon
    dbus
    libpulseaudio
    dotnetCorePackages.sdk_8_0_3xx
    alsa-lib
    icu
    # === Godot ===

    # === Ludusavi ===
    gtk3
    gtk4
    glib
    glibc
    # === Ludusavi ===
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
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

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # environment.variables = {
  # };

  environment.sessionVariables = {
    # === Prefer RADV driver ===
    AMD_VULKAN_ICD = "RADV";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";

    FLAKE = "/home/buymymojo/etc/nixos/";

    MANGOHUD = "1";

    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "1"; # Fixes godot 4 mono's launch issues
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
