{ config, pkgs, inputs, lib, ... }:

{
  # ========================================
  # GTK THEMING
  # ========================================
  gtk = {
    enable = true;

    # Theme
    theme = {
      name = "Catppuccin-Mocha-Standard-Teal-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ];
        size = "standard";
        tweaks = [ "rimless" "normal" ];
        variant = "mocha";
      };
    };

    # Icons
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # Cursor
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    # Font
    font = {
      name = "IBM Plex Sans";
      size = 11;
    };

    # GTK3 settings
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "appmenu:none";
    };

    # GTK4 settings
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "appmenu:none";
    };
  };

  # ========================================
  # QT THEMING
  # ========================================
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";
      package = pkgs.catppuccin-kvantum.override {
        accent = "Teal";
        variant = "Mocha";
      };
    };
  };

  # ========================================
  # CURSOR (Wayland)
  # ========================================
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # ========================================
  # KVANTUM CONFIGURATION
  # ========================================
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Mocha-Teal
  '';

  # ========================================
  # HYPRPAPER (WALLPAPER) CONFIGURATION
  # ========================================
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    # Preload wallpapers
    preload = ~/Pictures/Wallpapers/wallpaper.jpg

    # Set wallpaper for all monitors
    wallpaper = ,~/Pictures/Wallpapers/wallpaper.jpg

    # Settings
    splash = false
    ipc = on
  '';

  # ========================================
  # HYPRLOCK (LOCK SCREEN) CONFIGURATION
  # ========================================
  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = ~/Pictures/Wallpapers/wallpaper.jpg
      blur_passes = 3
      blur_size = 8
      noise = 0.02
      contrast = 0.9
      brightness = 0.7
      vibrancy = 0.2
      vibrancy_darkness = 0.0
    }

    input-field {
      monitor =
      size = 250, 50
      outline_thickness = 2
      dots_size = 0.2
      dots_spacing = 0.5
      dots_center = true
      dots_rounding = -1
      outer_color = rgba(94, 234, 212, 1)
      inner_color = rgba(30, 30, 46, 0.9)
      font_color = rgba(205, 214, 244, 1)
      fade_on_empty = true
      fade_timeout = 1000
      placeholder_text = <i>Password...</i>
      hide_input = false
      rounding = 15
      check_color = rgba(166, 227, 161, 1)
      fail_color = rgba(243, 139, 168, 1)
      fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
      fail_transition = 300
      capslock_color = rgba(249, 226, 175, 1)
      numlock_color = -1
      bothlock_color = -1
      invert_numlock = false
      swap_font_color = false
      position = 0, -50
      halign = center
      valign = center
    }

    label {
      monitor =
      text = $TIME
      text_align = center
      color = rgba(205, 214, 244, 1)
      font_size = 72
      font_family = IBM Plex Sans
      rotate = 0
      position = 0, 200
      halign = center
      valign = center
    }

    label {
      monitor =
      text = Hi, $USER
      text_align = center
      color = rgba(205, 214, 244, 1)
      font_size = 24
      font_family = IBM Plex Sans
      position = 0, 50
      halign = center
      valign = center
    }

    label {
      monitor =
      text = $LAYOUT
      text_align = center
      color = rgba(205, 214, 244, 0.7)
      font_size = 12
      font_family = IBM Plex Sans
      position = 0, -100
      halign = center
      valign = center
    }
  '';

  # ========================================
  # HYPRIDLE (IDLE DAEMON) CONFIGURATION
  # ========================================
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pidof hyprlock || hyprlock
      before_sleep_cmd = loginctl lock-session
      after_sleep_cmd = hyprctl dispatch dpms on
    }

    listener {
      timeout = 300  # 5 minutes
      on-timeout = brightnessctl -s set 10%
      on-resume = brightnessctl -r
    }

    listener {
      timeout = 600  # 10 minutes
      on-timeout = loginctl lock-session
    }

    listener {
      timeout = 900  # 15 minutes
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on
    }

    listener {
      timeout = 1800  # 30 minutes
      on-timeout = systemctl suspend
    }
  '';

  # ========================================
  # ADDITIONAL PACKAGES FOR THEMING
  # ========================================
  home.packages = with pkgs; [
    # Catppuccin themes
    catppuccin-gtk
    catppuccin-kvantum
    catppuccin-cursors

    # Icon themes
    papirus-icon-theme

    # Cursors
    bibata-cursors

    # Fonts
    ibm-plex
    inter

    # Theme managers
    nwg-look
    qt5ct
    qt6ct
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];
}
