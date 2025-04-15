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

  # === Java versions for MC ===
  home.file."jdks/zulujdk8".source = pkgs.zulu8;
  home.file."jdks/zulujdk17".source = pkgs.zulu17;
  home.file."jdks/zulujdk23".source = pkgs.zulu23;
  # === Java versions for MC ===

  home.packages =
    with pkgs;
    with unstable;
    with inputs;
    [
      # === Minecraft related ===
      unstable.modrinth-app
      unstable.prismlauncher
      # === Minecraft related ===

      steamtinkerlaunch
      heroic
      xivlauncher
      ludusavi

      # === Game perf ===
      mangojuice
      goverlay
      # unstable.mangohud
      # === Game perf ===

      # === Modding ===
      unstable.nexusmods-app-unfree
      # === Modding ===
    ];

  # programs.mangohud = {
  #  enable = true;
  #  enableSessionWide = true;
  #   package = unstable.mangohud;
  # };
}
