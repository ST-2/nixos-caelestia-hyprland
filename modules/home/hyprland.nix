{ config, pkgs, inputs, lib, ... }:

let
  # Animation bezier curves
  animations = {
    enabled = "yes";
    bezier = [
      "linear, 0.0, 0.0, 1.0, 1.0"
      "md3_standard, 0.2, 0.0, 0, 1.0"
      "md3_decel, 0.05, 0.7, 0.1, 1"
      "md3_accel, 0.3, 0, 0.8, 0.15"
      "overshot, 0.05, 0.9, 0.1, 1.05"
      "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
      "smoothIn, 0.25, 1.0, 0.5, 1.0"
      "holographic, 0.6, 0.04, 0.98, 0.335"
      "easeOutExpo, 0.16, 1, 0.3, 1"
      "easeInOutSine, 0.37, 0, 0.63, 1"
    ];
    animation = [
      "borderangle, 1, 50, linear, loop"
      "windows, 1, 3, md3_decel, slide"
      "windowsIn, 1, 3, md3_decel, slide"
      "windowsOut, 1, 3, md3_accel, slide"
      "windowsMove, 1, 3, md3_decel, slide"
      "border, 1, 3, smoothIn"
      "fade, 1, 3, md3_decel"
      "fadeIn, 1, 3, md3_decel"
      "fadeOut, 1, 2, md3_accel"
      "fadeDim, 1, 3, md3_decel"
      "workspaces, 1, 4, md3_decel, slide"
      "specialWorkspace, 1, 5, overshot, slidefadevert 50%"
      "layers, 1, 3, md3_decel, fade"
    ];
  };
in {
  # Hyprland home configuration
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;
    systemd.variables = ["--all"];

    settings = {
      # ========================================
      # MONITOR CONFIGURATION
      # ========================================
      # Adjust these to your monitors
      # Format: monitor=name,resolution@rate,position,scale
      monitor = [
        ",preferred,auto,1"  # Fallback for any monitor
        # Examples:
        # "DP-1, 2560x1440@144, 0x0, 1"
        # "eDP-1, 1920x1080@60, 2560x0, 1"
      ];

      # ========================================
      # VARIABLES
      # ========================================
      "$terminal" = "kitty";
      "$menu" = "caelestia shell toggle launcher";
      "$browser" = "firefox";
      "$fileManager" = "nautilus";

      # ========================================
      # ENVIRONMENT VARIABLES
      # ========================================
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];

      # ========================================
      # GENERAL APPEARANCE
      # ========================================
      general = {
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;

        # Material You 3 inspired gradient border - Teal/Cyan theme
        "col.active_border" = "rgba(5eead4ff) rgba(38bdf8ff) rgba(c084fcff) rgba(34d399ff) 270deg";
        "col.inactive_border" = "rgba(45475a88)";

        layout = "dwindle";
        resize_on_border = true;
        extend_border_grab_area = 15;
        hover_icon_on_border = true;
        allow_tearing = false;
      };

      # ========================================
      # DECORATION (Blur, Shadows, Rounding)
      # ========================================
      decoration = {
        rounding = 16;

        # Blur configuration
        blur = {
          enabled = true;
          size = 8;
          passes = 4;
          noise = 0.02;
          contrast = 0.9;
          brightness = 0.85;
          vibrancy = 0.2;
          vibrancy_darkness = 0.5;
        };

        # Shadow configuration
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
          color = "rgba(1a1a2e66)";
          color_inactive = "rgba(1a1a2e33)";
        };

        # Dimming inactive windows
        dim_inactive = true;
        dim_strength = 0.1;
        dim_special = 0.3;
      };

      # ========================================
      # ANIMATIONS
      # ========================================
      animations = animations;

      # ========================================
      # LAYOUTS
      # ========================================
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = false;
        smart_resizing = true;
        force_split = 2;  # Always split to the right/bottom
      };

      master = {
        new_status = "master";
        mfact = 0.55;
      };

      # ========================================
      # INPUT CONFIGURATION
      # ========================================
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = true;
          drag_lock = true;
        };
      };

      # ========================================
      # GESTURES
      # ========================================
      gestures = {
        # workspace_swipe = true; # Deprecated
        # workspace_swipe_fingers = 3; # Deprecated
        # workspace_swipe_distance = 300; # Deprecated
        # workspace_swipe_cancel_ratio = 0.5; # Deprecated
      };

      # ========================================
      # CURSOR
      # ========================================
      cursor = {
        inactive_timeout = 5;
        hide_on_key_press = true;
      };

      # ========================================
      # MISCELLANEOUS
      # ========================================
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        swallow_regex = "^(kitty|foot|Alacritty)$";
        focus_on_activate = true;
        # new_window_takes_over_fullscreen = 2; # Removed # Removed in newer Hyprland
      };

      # ========================================
      # XWAYLAND
      # ========================================
      xwayland = {
        force_zero_scaling = true;
      };

      # ========================================
      # KEY BINDINGS
      # ========================================
      "$mod" = "SUPER";
      "$alt" = "ALT";

      bind = [
        # === Core Bindings ===
        "$mod, Return, exec, $terminal"
        "$mod, W, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, E, exec, $fileManager"
        "$mod, B, exec, $browser"
        "$mod, T, togglefloating,"
        "$mod, F, fullscreen, 0"
        "$mod SHIFT, F, fullscreen, 1"  # Maximize
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"

        # === Caelestia Shell Bindings ===
        "$mod, SPACE, exec, caelestia shell toggle launcher"
        "$mod, D, exec, caelestia shell toggle dashboard"
        "$mod, S, exec, caelestia shell toggle session"
        "$mod, N, exec, caelestia shell toggle notifications"
        "$mod, M, exec, caelestia shell toggle media"

        # === Focus Movement (Vim-style) ===
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # === Window Movement ===
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # === Workspace Switching ===
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # === Move Window to Workspace ===
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # === Special Workspace (Scratchpad) ===
        "$mod, grave, togglespecialworkspace, magic"
        "$mod SHIFT, grave, movetoworkspace, special:magic"

        # === Workspace Navigation ===
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "$mod, bracketleft, workspace, e-1"
        "$mod, bracketright, workspace, e+1"

        # === Grouping ===
        "$mod, G, togglegroup,"
        "$mod, Tab, changegroupactive,"

        # === Screenshots (using grim + slurp) ===
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"
        "$mod, Print, exec, grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"

        # === Lock Screen ===
        "$mod SHIFT, L, exec, hyprlock"
      ];

      # === Mouse Bindings ===
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # === Repeating Bindings (hold to repeat) ===
      binde = [
        # Volume Control
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        # Brightness Control
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

        # Window Resizing
        "$mod CTRL, H, resizeactive, -30 0"
        "$mod CTRL, L, resizeactive, 30 0"
        "$mod CTRL, K, resizeactive, 0 -30"
        "$mod CTRL, J, resizeactive, 0 30"
      ];

      # ========================================
      # WINDOW RULES
      # ========================================
      windowrulev2 = [
        # Floating windows
        "float, class:^(pavucontrol)$"
        "float, class:^(nm-connection-editor)$"
        "float, class:^(blueman-manager)$"
        "float, class:^(org.gnome.Calculator)$"
        "float, class:^(file-roller)$"
        "float, class:^(nwg-look)$"
        "float, class:^(qt5ct)$"
        "float, class:^(qt6ct)$"
        "float, title:^(Picture-in-Picture)$"
        "float, title:^(Open File)$"
        "float, title:^(Save File)$"

        # Size constraints for floating
        "size 800 600, class:^(pavucontrol)$"
        "size 800 600, class:^(blueman-manager)$"

        # Center floating windows
        "center, floating:1"

        # Opacity rules
        "opacity 0.95 0.90, class:^(kitty)$"
        "opacity 0.95 0.90, class:^(foot)$"
        "opacity 0.95 0.90, class:^(Alacritty)$"
        "opacity 0.98 0.95, class:^(Code)$"
        "opacity 0.98 0.95, class:^(code-url-handler)$"

        # XWayland video bridge (for screen sharing)
        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"

        # Firefox PiP
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "size 640 360, title:^(Picture-in-Picture)$"
        "move 100%-660 50, title:^(Picture-in-Picture)$"

        # Polkit agent
        "float, class:^(polkit-gnome-authentication-agent-1)$"
        "center, class:^(polkit-gnome-authentication-agent-1)$"
      ];

      # ========================================
      # LAYER RULES (for Caelestia Shell)
      # ========================================
      layerrule = [
        # "blur, caelestia" # Deprecated layerrule
        # "ignorealpha 0.3, caelestia" # Deprecated
        # "blur, notifications" # Deprecated
        # "ignorealpha 0.3, notifications" # Deprecated
        # "blur, rofi" # Deprecated
        # "ignorealpha 0.3, rofi" # Deprecated
      ];

      # ========================================
      # AUTOSTART
      # ========================================
      exec-once = [
        # Polkit agent for authentication
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

        # Wallpaper daemon
        "hyprpaper"

        # Clipboard manager
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        # Note: Caelestia Shell is started via systemd service
      ];
    };

    # Extra configuration (raw hyprland.conf additions)
    extraConfig = ''
      # You can add raw Hyprland config here
      # Example: custom plugins, device-specific config, etc.
    '';
  };
}
