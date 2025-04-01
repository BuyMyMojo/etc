{
  config,
  pkgs,
  unstable,
  gsr-ui,
  inputs,
  ...
}:

{

  home.file."jdks/zulujdk8".source = pkgs.zulu8;
  home.file."jdks/zulujdk17".source = pkgs.zulu17;
  home.file."jdks/zulujdk23".source = pkgs.zulu23;

  home.file."bin/wine".source = unstable.wineWowPackages.waylandFull;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with unstable;
    with inputs;
    [
      pkgs.nextcloud-client
      pkgs.xpipe
      pkgs.monero-gui
      unstable.kiwix

      # pkgs.protonplus
      unstable.pcsx2
      pkgs.rpcs3
      unstable.ryubing
      unstable.torzu
      pkgs.heroic-unwrapped
      unstable.ludusavi
      inputs.shadps4-git.packages."x86_64-linux".default

      unstable.wineWowPackages.waylandFull
      unstable.winetricks
      steamtinkerlaunch

      # === Minecraft ===
      pkgs.prismlauncher
      # pkgs.zulu8
      # pkgs.zulu17
      # pkgs.zulu23
      # === Minecraft ===

      # === CLI ===
      pkgs.rrsync
      pkgs.poop # Compare the performance of multiple commands with a colorful terminal user interface
      pkgs.age
      pkgs.jujutsu
      pkgs.lazyjj
      pkgs.biome
      # === CLI ===

      # === Image CLI ===
      unstable.oxipng
      unstable.image_optim
      unstable.jpegoptim
      pkgs.libjxl
      pkgs.libavif
      pkgs.libwebp
      pkgs.imagemagick
      # === Image CLI ===

      # === Game perf ===
      unstable.mangojuice
      unstable.goverlay
      # === Game perf ===

      # === Dev tooling ===
      # pkgs.rustup
      # === Dev tooling ===

      # pkgs.polychromatic

      pkgs.lazydocker
      pkgs.distrobox
      pkgs.boxbuddy

      unstable.gpu-screen-recorder-gtk
      gsr-ui.gpu-screen-recorder-ui

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    package = unstable.mangohud;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-pipewire-audio-capture
      obs-teleport
      obs-source-record
      obs-source-clone
      obs-composite-blur
    ];
  };

  # === ssh ===
  programs.ssh.matchBlocks = {
    "*" = {
      identityFile = "/home/buymymojo/.ssh/id_ed25519-mainpc";
    };

    "game2.buymymojo.net" = {
      hostname = "game2.buymymojo.net";
      user = "jumpbox";
      identityFile = "/home/buymymojo/.ssh/id_ed25519-mainpc";
    };

    "git.aria.coffee" = {
      hostname = "git.aria.coffee";
      user = "git";
      identityFile = "/home/buymymojo/.ssh/id_ed25519-mainpc";
      port = 23;
    };
  };

}
