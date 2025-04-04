{
  config,
  pkgs,
  unstable,
  inputs,
  ...
}:

{

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

      # === Dev tooling ===
      # pkgs.rustup
      # === Dev tooling ===

      # pkgs.polychromatic



      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

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
