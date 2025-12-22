# 🌟 NixOS Configuration with Caelestia Shell + Hyprland Rice

A beautiful, modern NixOS configuration featuring:
- **Caelestia Shell** - A stunning QuickShell-based desktop shell
- **Hyprland** - Dynamic tiling Wayland compositor
- **Material You** inspired theming with animated gradient borders
- **Catppuccin Mocha** color scheme
- **Comprehensive ricing** - blur, shadows, animations, rounded corners

## 📸 Features

- 🎨 Material You 3 inspired gradient borders (teal/cyan/purple)
- 🌫️ Gaussian blur with vibrancy effects
- ✨ Smooth Material Design 3 animations
- 🖼️ Rounded corners (16px) on all windows
- 🌙 Beautiful lock screen with hyprlock
- 🎯 Smart window rules and special workspaces
- ⌨️ Vim-style keybindings
- 🚀 Fast application launching via Caelestia

## 📋 Prerequisites

1. A working NixOS installation with flakes enabled
2. `git` installed
3. A backup of your current configuration

## 🚀 Installation

### Step 1: Clone this configuration

```bash
# Clone to your preferred location
git clone <your-repo-url> ~/.config/nixos
cd ~/.config/nixos
```

### Step 2: Generate hardware configuration

```bash
sudo nixos-generate-config --show-hardware-config > hosts/default/hardware-configuration.nix
```

### Step 3: Customize the configuration

Edit the following files to match your system:

1. **`flake.nix`**:
   - Change `caelestia-pc` to your hostname
   - Change `user` to your username

2. **`hosts/default/configuration.nix`**:
   - Set your hostname
   - Set your timezone
   - Set your locale
   - Configure your user

3. **`modules/home/default.nix`**:
   - Change `username` to your username
   - Change `homeDirectory` to match

4. **`modules/home/hyprland.nix`**:
   - Configure your monitors in the `monitor` section
   - Adjust keybindings if needed

5. **`modules/home/packages.nix`**:
   - Update git username and email
   - Add/remove packages as needed

6. **`modules/home/theme.nix`**:
   - Create wallpaper directory and add wallpapers:
     ```bash
     mkdir -p ~/Pictures/Wallpapers
     # Add your wallpaper as wallpaper.jpg
     ```

### Step 4: Build and switch

```bash
# First build (may take a while)
sudo nixos-rebuild switch --flake .#caelestia-pc

# Or if using home-manager standalone:
home-manager switch --flake .#user@caelestia-pc
```

### Step 5: Reboot

```bash
sudo reboot
```

## ⌨️ Keybindings

### Core
| Keybind | Action |
|---------|--------|
| `Super + Return` | Open terminal (kitty) |
| `Super + Q` | Close window |
| `Super + Shift + Q` | Exit Hyprland |
| `Super + Space` | Open Caelestia launcher |
| `Super + D` | Toggle Caelestia dashboard |
| `Super + S` | Toggle Caelestia session menu |
| `Super + V` | Toggle floating |
| `Super + F` | Toggle fullscreen |

### Window Navigation (Vim-style)
| Keybind | Action |
|---------|--------|
| `Super + H/J/K/L` | Focus left/down/up/right |
| `Super + Shift + H/J/K/L` | Move window left/down/up/right |
| `Super + Ctrl + H/J/K/L` | Resize window |

### Workspaces
| Keybind | Action |
|---------|--------|
| `Super + 1-0` | Switch to workspace 1-10 |
| `Super + Shift + 1-0` | Move window to workspace 1-10 |
| `Super + [/]` | Previous/Next workspace |
| `Super + ` ` ` | Toggle special workspace |

### Screenshots
| Keybind | Action |
|---------|--------|
| `Print` | Screenshot region to clipboard |
| `Shift + Print` | Screenshot full screen to clipboard |
| `Super + Print` | Screenshot region to file |

### Media & System
| Keybind | Action |
|---------|--------|
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86AudioMute` | Toggle mute |
| `XF86MonBrightnessUp/Down` | Brightness control |
| `Super + Shift + L` | Lock screen |

## 📁 Structure

```
.
├── flake.nix                          # Main flake configuration
├── flake.lock                         # Lock file (auto-generated)
├── hosts/
│   └── default/
│       ├── configuration.nix          # System configuration
│       └── hardware-configuration.nix # Hardware config (generate this)
└── modules/
    ├── hyprland.nix                   # System-level Hyprland config
    └── home/
        ├── default.nix                # Main home-manager config
        ├── hyprland.nix               # Hyprland window manager settings
        ├── packages.nix               # User packages and program configs
        └── theme.nix                  # GTK/Qt theming and appearance
```

## 🎨 Customization

### Changing the color scheme

The configuration uses **Catppuccin Mocha** with **Teal** accent. To change:

1. **Border colors** in `modules/home/hyprland.nix`:
   ```nix
   "col.active_border" = "rgba(...)";
   ```

2. **GTK theme** in `modules/home/theme.nix`:
   ```nix
   accents = [ "teal" ];  # Change to: blue, pink, mauve, etc.
   ```

3. **Kvantum (Qt) theme**: Also in `modules/home/theme.nix`

### Adding more monitors

Edit `modules/home/hyprland.nix`:
```nix
monitor = [
  "DP-1, 2560x1440@144, 0x0, 1"
  "eDP-1, 1920x1080@60, 2560x0, 1"
];
```

### Caelestia Shell settings

Edit `modules/home/default.nix` under `programs.caelestia.settings`.

## 🔧 Troubleshooting

### Caelestia Shell not starting

1. Check the systemd service:
   ```bash
   systemctl --user status caelestia
   journalctl --user -u caelestia -f
   ```

2. Ensure Hyprland session target is active:
   ```bash
   systemctl --user status hyprland-session.target
   ```

### Fonts not showing correctly

1. Rebuild font cache:
   ```bash
   fc-cache -fv
   ```

2. Ensure Material Symbols font is installed

### Blur not working

1. Check if your GPU supports it
2. Ensure `decoration.blur.enabled = true`
3. Try reducing `passes` if performance is poor

### Lock screen not working

1. Ensure hyprlock is installed
2. Check the config at `~/.config/hypr/hyprlock.conf`

## 📚 Resources

- [Caelestia Shell](https://github.com/caelestia-dots/shell)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Catppuccin](https://catppuccin.com/)

## 📜 License

MIT License - Feel free to use and modify!

## 🙏 Credits

- [Caelestia Dots](https://github.com/caelestia-dots) - For the amazing shell
- [TLSingh1](https://github.com/TLSingh1/dotfiles) - NixOS integration reference
- [Hyprland](https://hyprland.org/) - The compositor
- [Catppuccin](https://catppuccin.com/) - The color palette
