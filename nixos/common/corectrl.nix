{
  config,
  pkgs,
  unstable,
  inputs,
  nix-your-shell,
  ...
}:

{
  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };
}
