{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix
  ];

  # ========================================
  # BOOTLOADER
  # ========================================
  # Using GRUB for broader compatibility (works on both BIOS/MBR and UEFI)
  # If you're on UEFI and prefer systemd-boot, uncomment below and comment out GRUB section
  # boot.loader = {
  #   systemd-boot.enable = true;
  #   efi.canTouchEfiVariables = true;
  # };
  
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";  # Change this to your boot disk (e.g., /dev/vda, /dev/nvme0n1)
    useOSProber = true;
  };

  # ========================================
  # NETWORKING
  # ========================================
  networking = {
    hostName = "caelestia-pc";  # Change this
    networkmanager.enable = true;
  };

  # ========================================
  # LOCALIZATION
  # ========================================
  time.timeZone = "America/Los_Angeles";  # Change this
  i18n.defaultLocale = "en_US.UTF-8";

  # ========================================
  # USERS
  # ========================================
  users.users.user = {  # Change "user" to your username
    isNormalUser = true;
    description = "User";  # Change this
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "input"
      "i2c"  # For ddcutil (external monitor control)
    ];
    shell = pkgs.fish;
    initialPassword = "changeme";  # Change this after first login with `passwd`
  };

  # ========================================
  # SYSTEM PACKAGES
  # ========================================
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    htop
    unzip
    file
  ];

  # ========================================
  # PROGRAMS
  # ========================================
  programs = {
    fish.enable = true;
    dconf.enable = true;  # Required for GTK theming
  };

  # ========================================
  # NIX SETTINGS
  # ========================================
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      # Hyprland cachix
      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+ voices5h1qNMuV9LFx52O3GqgRBROWUJuLg="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # ========================================
  # NIXPKGS
  # ========================================
  nixpkgs.config.allowUnfree = true;

  # ========================================
  # HARDWARE
  # ========================================
  hardware = {
    graphics.enable = true;  # Required for Hyprland
    i2c.enable = true;  # For ddcutil
  };

  # ========================================
  # SECURITY
  # ========================================
  security.rtkit.enable = true;  # Required for PipeWire

  # ========================================
  # SYSTEM STATE VERSION
  # ========================================
  system.stateVersion = "24.11";  # Don't change this
}
