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
    with pkgs;
    with unstable;
    with inputs;
    [
      svt-av1-psy
      # unstable.ffmpeg-full
      ab-av1
      # whisper-cpp-vulkan
      video-compare
    ];

}
