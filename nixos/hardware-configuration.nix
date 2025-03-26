# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  unstable,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "uas"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  # boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0f2c323f-446e-4f3b-a188-be7ab574a6b2";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3466-259A";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/home/buymymojo/Videos" = {
    device = "/dev/disk/by-uuid/2f5047c5-49ea-455d-ae29-9d8e07a77181";
    fsType = "ext4";
    options = [
      "users"
      "nofail"
      "x-gvfs-show"
      "x-gvfs-name=Videos"
      "exec"
      "rw"
    ];
  };

  fileSystems."/run/media/buymymojo/KingstonSSD" = {
    device = "/dev/disk/by-uuid/ad01c809-a2dc-48b2-b1f8-95d8d341b586";
    fsType = "ext4";
    options = [
      "nofail"
      "users"
      "x-gvfs-show"
      "x-gvfs-name=KingstonSSD"
      "exec"
    ];
  };

  fileSystems."/run/media/buymymojo/sde1" = {
    device = "/dev/disk/by-uuid/0630447f-36b0-4355-9734-8aea1c318d56";
    fsType = "ext4";
    options = [
      "nofail"
      "users"
      "x-gvfs-show"
      "x-gvfs-name=CrucialBX500"
      "exec"
    ];
  };

  fileSystems."/run/media/buymymojo/sdf2" = {
    device = "/dev/disk/by-uuid/718f9731-8652-4146-90be-864ccde39e3f";
    fsType = "btrfs";
    options = [
      "compress=zstd:4"
      "x-gvfs-name=data"
      "nofail"
      "users"
      "x-gvfs-show"
      "rw"
      "exec"
    ];
  };

  fileSystems."/run/media/buymymojo/1TB\040HDD" = {
    device = "/dev/disk/by-uuid/17533a6c-2ac3-4765-b620-21214c752dc5";
    fsType = "btrfs";
    options = [
      "nosuid"
      "nodev"
      "x-gvfs-show"
      "x-gvfs-name=1TB%20HDD"
      "exec"
      "nofail"
      "users"
      "compress=zstd:4"
    ];
  };

  fileSystems."/run/media/buymymojo/Gen4-SSD" = {
    device = "/dev/disk/by-uuid/ce2d927a-be94-476f-aa36-b1daf5d92ace";
    fsType = "auto";
    options = [
      "nosuid"
      "nodev"
      "nofail"
      "x-gvfs-show"
      "x-gvfs-name=Gen4-SSD"
      "exec"
      "compress=zstd:1"
    ];
  };

  fileSystems."/run/media/buymymojo/SamsungSSD" = {
    device = "/dev/disk/by-uuid/3bf433b1-a75d-47d0-9d7f-da8efe69387e";
    fsType = "btrfs";
    options = [
      "nofail"
      "users"
      "exec"
      "x-gvfs-show"
      "x-gvfs-name=SamsungSSD"
      "compress=zstd:1"
    ];
  };

  fileSystems."/run/media/buymymojo/2TB-WDHDD" = {
    device = "/dev/disk/by-uuid/fc8b438e-78ed-41bf-bac2-c821fd647136";
    fsType = "btrfs";
    options = [
      "nosuid"
      "nodev"
      "nofail"
      "x-gvfs-show"
      "x-gvfs-name=2TB-WDHDD"
      "exec"
      "compress=zstd:1"
    ];
  };

  fileSystems."/run/media/buymymojo/4TB-SSD" = {
    device = "/dev/disk/by-uuid/9388e9a7-ea7b-4fb4-8062-93255a64b22f";
    fsType = "btrfs";
    options = [
      "nosuid"
      "nodev"
      "nofail"
      "x-gvfs-show"
      "x-gvfs-name=4TB-SSD"
      "exec"
      "compress=zstd:1"
    ];
  };

  fileSystems."/run/media/buymymojo/ExternalLinuxHDD" = {
    device = "/dev/disk/by-uuid/75d0408e-9e2c-47d0-aec3-cbc910d3c7d5";
    fsType = "ext4";
    options = [
      "nosuid"
      "nodev"
      "nofail"
      "x-gvfs-show"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/64f19dfc-26bb-471b-81c5-ffb54e4191a5"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware = {
    graphics = {
      # === vulkan/mesa ===
      enable = true;
      enable32Bit = true;
      package = unstable.mesa;
      # === vulkan/mesa ===

      # === amdvlk driver ===
      extraPackages = with pkgs; [
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
      # === amdvlk driver ===

    };

    openrazer.enable = true;

  };
}
