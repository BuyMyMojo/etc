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

#  imports = [
#    inputs.moonlight.homeModules.default
#  ];

  home.packages =
    with pkgs;
    with inputs;
    with unstable;
    [
      pkgs.yubioath-flutter
      pkgs.qbittorrent
      peazip
      parsec-bin

      # === Communication ===
      pkgs.vesktop
      # (unstable.discord-canary.override { withMoonlight = true; })
      # (unstable.discord.override { withMoonlight = true; })
      pkgs.signal-desktop
      pkgs.telegram-desktop
      # pkgs.thunderbird-latest-unwrapped
      # === Communication ===

      # === Editors/Office ===
      libreoffice-fresh
      # pkgs.kdePackages.kate
      pkgs.jetbrains.webstorm
      pkgs.jetbrains.rider
      pkgs.jetbrains.idea-community
      vscode.fhs # .fhs version will be more compatable even if slightly less nix flavoured
      # === Editors/Office ===

      # === Media ===
      # unstable.gimp
      krita
      mpv
      losslesscut-bin
      jellyfin-media-player
      makemkv
      kdePackages.k3b
      # === Media ===

      orca-slicer
      exodus
    ];

#  programs.moonlight-mod = {
#    enable = true;
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
#  };

}
