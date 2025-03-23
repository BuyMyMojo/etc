# make a  derivation for berkeley-mono font installation
{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "berkeley-mono-typeface";
  version = "2.002";

  src = "../assets/TX-02 2.002.zip";

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 "TX-02 2.002/*.ttf" -t $out/share/fonts/truetype

    runHook postInstall
  '';
}