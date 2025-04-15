{
  config,
  pkgs,
  unstable,
  inputs,
  nix-your-shell,
  ...
}:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # === Godot ===
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXext
    xorg.libXrandr
    xorg.libXrender
    xorg.libX11
    xorg.libXi
    libGL
    wayland
    wayland-scanner
    vulkan-loader
    fontconfig
    libxkbcommon
    dbus
    libpulseaudio
    dotnetCorePackages.sdk_8_0_3xx
    alsa-lib
    icu
    haskellPackages.bz2
    # === Godot ===

    # === Ludusavi ===
    gtk3
    gtk4
    glib
    glibc
    # === Ludusavi ===

    # === html wallpaper ===
    python312Packages.pyqt6-webengine
    # ===

    zlib
    zstd
    stdenv.cc.cc
    curl
    openssl
    attr
    libssh
    bzip2
    libxml2
    acl
    libsodium
    util-linux
    xz
    systemd

    # === jpegqs & jpeg2png ===
    mozjpeg
    libjpeg
    libjpeg8
    libpng
    # === jpegqs & jpeg2png ===

    # === 3d printing ===
    xorg.libxcb
    # === 3d printing ===
  ];
}
