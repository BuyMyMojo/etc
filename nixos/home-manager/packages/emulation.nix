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

  home.packages =
    with unstable;
    with inputs;
    [
      unstable.pcsx2
      unstable.rpcs3
      unstable.ryubing
      unstable.torzu
      inputs.shadps4-git.packages."x86_64-linux".default
    ];
}

