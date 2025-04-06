{
  config,
  pkgs,
  unstable,
  inputs,
  lib,
  ...
}:

let
  withExtraPackages =
    pkg: extraPackages:
    pkgs.runCommand "${pkg.name}-wrapped" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
      for exe in ${lib.getBin pkg}/bin/*; do
        makeWrapper $exe $out/bin/$(basename $exe) --prefix PATH : ${lib.makeBinPath extraPackages}
      done
    '';
in
{

  imports = [
    inputs.moonlight.homeModules.default
  ];

  home.packages =
    with inputs;
    with unstable;
    [
      pkgs.yubioath-flutter
      pkgs.qbittorrent
      unstable.peazip
      unstable.parsec-bin

      # === Communication ===
      pkgs.vesktop
      pkgs.discord-canary
      pkgs.discord
      pkgs.signal-desktop
      pkgs.telegram-desktop
      # pkgs.thunderbird-latest-unwrapped
      # === Communication ===

      # === Editors/Office ===
      unstable.libreoffice-fresh
      # pkgs.kdePackages.kate
      pkgs.jetbrains.webstorm
      pkgs.jetbrains.rider
      pkgs.jetbrains.idea-community
      vscode.fhs # .fhs version will be more compatable even if slightly less nix flavoured
      # === Editors/Office ===

      # === Media ===
      # unstable.gimp
      unstable.krita
      unstable.mpv
      unstable.losslesscut-bin
      unstable.jellyfin-media-player
      unstable.makemkv
      # === Media ===

      unstable.orca-slicer
    ];

  programs.moonlight-mod = {
    enable = true;
    # stable = {
    #   extensions = {
    #     allActivites.enabled = true;
    #     alwaysFocus.enabled = true;

    #     betterEmbedsYT = {
    #       enabled = true;
    #       config = {
    #         fullDescription = false;
    #         expandDescription = true;
    #       };
    #     };
    #   };
    # };
  };

}
