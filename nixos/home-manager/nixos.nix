{
  config,
  pkgs,
  unstable,
  inputs,
  ...
}:

{

  imports = [
    ./nixos/packages.nix
    ./nixos/services.nix

    ./packages/gamedev.nix

    ./packages/common-cli.nix
    ./packages/common-desktop.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "buymymojo";
  home.homeDirectory = "/home/buymymojo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/buymymojo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  home.sessionPath = [
    "/home/buymymojo/bin/"
  ];

  programs.git = {
    signing.key = "E7B7B8D20C8753C077F9B17119AB7AA462B8AB3B";
  };

  programs.ssh.matchBlocks = {
    "*" = {
      identityFile = "/home/buymymojo/.ssh/id_ed25519-mainpc";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
