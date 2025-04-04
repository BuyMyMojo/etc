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
  home.file."bin/wine".source = unstable.wineWowPackages.waylandFull;

  home.packages =
    with unstable;
    with inputs;
    [
      unstable.wineWowPackages.waylandFull
      unstable.winetricks
    ];

}
