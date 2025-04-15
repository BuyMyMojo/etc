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
    inputs.bellado.homeManagerModules.default
  ];

  home.packages =
    with pkgs;
    with unstable;
    with inputs;
    [
      stow
      yt-dlp
      aria2
      ripgrep
      wl-clipboard
      bat
      btop

      fzf
      dwarfs
      unrar
    ];

  programs.neovim = {
    # package = unstable.neovim;
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

  };

  programs.git = {
    enable = true;
    userName = "BuyMyMojo";
    userEmail = "hello+git@buymymojo.net";
    lfs.enable = true;
    signing.signByDefault = true;
    extraConfig = {
      init = {

        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.bellado = {
    enable = true;
    enableAliases = true;
  };

  programs.ssh.enable = true;
  programs.ssh.addKeysToAgent = "yes";

  # === ssh ===
  programs.ssh.matchBlocks = {
    "game2.buymymojo.net" = {
      hostname = "game2.buymymojo.net";
      user = "jumpbox";
    };

    "git.aria.coffee" = {
      hostname = "git.aria.coffee";
      user = "git";
      port = 23;
    };

    "vtt.buymymojo.net" = {
    	hostname = "vtt.buymymojo.net";
	user = "admin";
    };
  };

  # === shells ===
  programs.bash.enable = true;
  programs.fish.enable = true;

}
