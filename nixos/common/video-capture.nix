{
  config,
  pkgs,
  unstable,
  inputs,
  nix-your-shell,
  ...
}:

{
  programs.gpu-screen-recorder = {
    enable = true;
    package = unstable.gpu-screen-recorder;
  };
}
