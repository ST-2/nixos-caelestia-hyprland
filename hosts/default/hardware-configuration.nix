# PLACEHOLDER - REPLACE WITH YOUR HARDWARE CONFIGURATION
# Generate with: sudo nixos-generate-config --show-hardware-config > hosts/default/hardware-configuration.nix
#
# This is a minimal placeholder to allow flake evaluation.
# It MUST be replaced before building your system!

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # PLACEHOLDER VALUES - REPLACE THESE
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];  # or kvm-amd for AMD
  boot.extraModulePackages = [ ];

  # Root filesystem - MUST BE CONFIGURED
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";  # CHANGE THIS
    fsType = "ext4";  # or btrfs, etc.
  };

  # Boot partition - MUST BE CONFIGURED  
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";  # CHANGE THIS
    fsType = "vfat";
  };

  swapDevices = [ ];

  # Networking
  networking.useDHCP = lib.mkDefault true;

  # Platform
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
