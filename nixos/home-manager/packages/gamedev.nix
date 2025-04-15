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

  home.file."Godot/current".source = unstable.godot;
  home.file."Godot/current-mono".source = unstable.godot-mono;
  home.file."Godot/export-templates/current".source = unstable.godot-export-templates;
  home.file."Godot/4.3".source = unstable.godot_4_3;
  home.file."Godot/4.3-mono".source = unstable.godot_4_3-mono;
  home.file."Godot/export-templates/4.3".source = unstable.godot_4_3-export-templates;

  home.packages =
    with pkgs;
    with unstable;
    with inputs;
    [
      unstable.godot
      unstable.godot-export-templates
      unstable.blender-hip
      unstable.freecad-wayland
      unstable.unityhub
      pkgs.material-maker
      unstable.blockbench
    ];
}
