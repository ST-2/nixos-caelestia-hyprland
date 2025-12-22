{ config, pkgs, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    # ========================================
    # TERMINALS
    # ========================================
    kitty
    foot
    alacritty

    # ========================================
    # BROWSERS
    # ========================================
    firefox
    chromium

    # ========================================
    # FILE MANAGERS
    # ========================================
    nautilus
    nemo

    # ========================================
    # DEVELOPMENT
    # ========================================
    vscode
    neovim
    git
    gh
    lazygit

    # ========================================
    # MEDIA
    # ========================================
    mpv
    imv          # Image viewer
    spotify
    playerctl    # Media player control

    # ========================================
    # UTILITIES
    # ========================================
    ripgrep
    fd
    fzf
    eza          # Modern ls
    bat          # Modern cat
    zoxide       # Smart cd
    starship     # Prompt
    fastfetch    # System info
    btop         # System monitor

    # ========================================
    # WAYLAND/HYPRLAND SPECIFIC
    # ========================================
    hyprpaper    # Wallpaper daemon
    hyprlock     # Lock screen
    hypridle     # Idle daemon
    hyprpicker   # Color picker
    wl-clipboard
    cliphist     # Clipboard manager
    grim         # Screenshots
    slurp        # Area selection
    swappy       # Screenshot editor
    wayfreeze    # Screen freeze for screenshots
    wl-screenrec # Screen recording

    # ========================================
    # CAELESTIA DEPENDENCIES
    # ========================================
    imagemagick
    socat
    jq
    python3
    python3Packages.materialyoucolor
    python3Packages.pillow
    cava         # Audio visualizer

    # ========================================
    # ASTAL/AGS WIDGETS (Alternative to Caelestia)
    # ========================================
    inputs.astal.packages.${pkgs.system}.default

    # ========================================
    # NOTIFICATION
    # ========================================
    libnotify

    # ========================================
    # THEMING
    # ========================================
    nwg-look     # GTK settings
    libsForQt5.qt5ct
    qt6Packages.qt6ct

    # ========================================
    # FONTS
    # ========================================
    material-symbols
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
    ibm-plex
    rubik
    inter

    # ========================================
    # OFFICE/PRODUCTIVITY
    # ========================================
    obsidian
    libreoffice

    # ========================================
    # COMMUNICATION
    # ========================================
    vesktop      # Discord client
    telegram-desktop
  ];

  # ========================================
  # PROGRAM CONFIGURATIONS
  # ========================================

  # Kitty terminal
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;
      background_opacity = "0.92";
      dynamic_background_opacity = true;
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 10;

      # Catppuccin Mocha inspired colors
      foreground = "#cdd6f4";
      background = "#1e1e2e";
      selection_foreground = "#1e1e2e";
      selection_background = "#f5e0dc";
      cursor = "#f5e0dc";
      cursor_text_color = "#1e1e2e";
      url_color = "#f5e0dc";

      # Normal colors
      color0 = "#45475a";
      color1 = "#f38ba8";
      color2 = "#a6e3a1";
      color3 = "#f9e2af";
      color4 = "#89b4fa";
      color5 = "#f5c2e7";
      color6 = "#94e2d5";
      color7 = "#bac2de";

      # Bright colors
      color8 = "#585b70";
      color9 = "#f38ba8";
      color10 = "#a6e3a1";
      color11 = "#f9e2af";
      color12 = "#89b4fa";
      color13 = "#f5c2e7";
      color14 = "#94e2d5";
      color15 = "#a6adc8";
    };
  };

  # Fish shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      starship init fish | source
      zoxide init fish | source
    '';
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons";
      lt = "eza --tree --icons";
      cat = "bat";
      grep = "rg";
      find = "fd";
      vim = "nvim";
      lg = "lazygit";
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      directory = {
        truncation_length = 3;
        fish_style_pwd_dir_length = 1;
      };
      git_branch = {
        symbol = " ";
      };
      nix_shell = {
        symbol = " ";
      };
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = "Your Name";  # Change this
    userEmail = "your.email@example.com";  # Change this
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };

  # Fuzzel (application launcher - backup for Caelestia)
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty";
        font = "JetBrainsMono Nerd Font:size=12";
        width = 50;
        horizontal-pad = 20;
        vertical-pad = 15;
        inner-pad = 10;
        layer = "overlay";
      };
      colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        match = "89b4faff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "89b4faff";
        border = "89b4faff";
      };
      border = {
        width = 2;
        radius = 15;
      };
    };
  };
}
