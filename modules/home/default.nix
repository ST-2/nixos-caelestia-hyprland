{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    # Import Caelestia home-manager module
    inputs.caelestia-shell.homeManagerModules.default

    # Import local modules
    ./hyprland.nix
    ./packages.nix
    ./theme.nix
  ];

  # Basic home configuration
  home = {
    username = "user";  # Change to your username
    homeDirectory = "/home/user";  # Change to your home directory
    stateVersion = "24.11";

    # Session variables for Caelestia
    sessionVariables = {
      C_DATA = "${config.xdg.dataHome}/caelestia";
      C_STATE = "${config.xdg.stateHome}/caelestia";
      C_CACHE = "${config.xdg.cacheHome}/caelestia";
      C_CONFIG = "${config.xdg.configHome}/caelestia";
      EDITOR = "nvim";
      TERMINAL = "kitty";
      BROWSER = "firefox";
    };
  };

  # Enable Caelestia Shell
  programs.caelestia = {
    enable = true;
    # Use the with-cli package for full functionality
    package = inputs.caelestia-shell.packages.${pkgs.system}.with-cli;

    # Systemd service configuration
    systemd = {
      enable = true;
      target = "hyprland-session.target";
      environment = [
        "QT_QPA_PLATFORMTHEME=gtk3"
      ];
    };

    # Caelestia shell settings - customize as needed
    settings = {
      # General settings
      general = {
        # Theme variant: "dark" or "light"
        theme = "dark";
      };

      # Bar/Panel settings
      bar = {
        # Position: "top" or "bottom"
        position = "top";
      };
    };

    # Enable Caelestia CLI
    cli = {
      enable = true;
      settings = {
        # CLI-specific settings
      };
    };
  };

  # Create necessary directories
  home.activation.caelestiaSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${config.xdg.dataHome}/caelestia
    mkdir -p ${config.xdg.stateHome}/caelestia/scheme
    mkdir -p ${config.xdg.cacheHome}/caelestia/thumbnails
    mkdir -p ${config.xdg.configHome}/caelestia
  '';

  # Enable home-manager
  programs.home-manager.enable = true;

  # XDG base directories
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
