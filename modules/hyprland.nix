{ config, pkgs, inputs, lib, ... }:

{
  # Enable Hyprland at the system level
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # XDG Portal configuration
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Required services for a nice desktop experience
  services = {
    # Display manager - you can use gdm, sddm, or greetd
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    # Bluetooth
    blueman.enable = true;
  };

  # Hardware support
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # Required system packages for Hyprland + Caelestia
  environment.systemPackages = with pkgs; [
    # Core utilities
    wl-clipboard
    wl-screenrec
    grim
    slurp
    swappy

    # Brightness and display control
    brightnessctl
    ddcutil

    # Network and Bluetooth
    networkmanagerapplet
    blueman

    # Audio control
    pavucontrol
    pamixer

    # System monitoring
    lm_sensors
    htop
    btop

    # Fonts (required for Caelestia)
    material-symbols
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
    ibm-plex
    rubik

    # Other essentials
    polkit_gnome
    libnotify
  ];

  # Enable polkit for authentication dialogs
  security.polkit.enable = true;

  # Font configuration
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "IBM Plex Serif" ];
        sansSerif = [ "IBM Plex Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

  # Environment variables for Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland,x11";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
