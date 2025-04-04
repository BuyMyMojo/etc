{
  config,
  pkgs,
  unstable,
  inputs,
  lib,
  gsr-ui,
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
      unstable.gpu-screen-recorder-gtk
      gsr-ui.gpu-screen-recorder-ui
    ];

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

}
