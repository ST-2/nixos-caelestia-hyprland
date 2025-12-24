#!/usr/bin/env bash
# NixOS Caelestia + Hyprland Installation Script
# Usage: curl -fsSL https://raw.githubusercontent.com/ST-2/nixos-caelestia-hyprland/main/install.sh | bash

set -e

echo "🌟 NixOS Caelestia + Hyprland Rice Installer"
echo "============================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if running on NixOS
if [ ! -f /etc/NIXOS ]; then
    echo -e "${RED}Error: This script must be run on NixOS${NC}"
    exit 1
fi

# Check for git
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is required. Install it first.${NC}"
    exit 1
fi

# Default values
CONFIG_DIR="${HOME}/.config/nixos"
HOSTNAME=$(hostname)
USERNAME=$(whoami)

echo -e "${BLUE}Configuration:${NC}"
echo "  Config directory: ${CONFIG_DIR}"
echo "  Hostname: ${HOSTNAME}"
echo "  Username: ${USERNAME}"
echo ""

# Backup existing config
if [ -d "${CONFIG_DIR}" ]; then
    BACKUP_DIR="${CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}Backing up existing config to ${BACKUP_DIR}${NC}"
    mv "${CONFIG_DIR}" "${BACKUP_DIR}"
fi

# Clone the repository
echo -e "${GREEN}Cloning NixOS Caelestia configuration...${NC}"
git clone https://github.com/ST-2/nixos-caelestia-hyprland.git "${CONFIG_DIR}"
cd "${CONFIG_DIR}"

# Generate hardware configuration
echo -e "${GREEN}Generating hardware configuration...${NC}"
sudo nixos-generate-config --show-hardware-config > hosts/default/hardware-configuration.nix

# Update hostname in flake.nix (the nixosConfigurations key)
echo -e "${GREEN}Configuring hostname: ${HOSTNAME}${NC}"
sed -i "s/caelestia-pc = nixpkgs/${HOSTNAME} = nixpkgs/" flake.nix
sed -i "s/\"caelestia-pc\" with your hostname/\"${HOSTNAME}\" with your hostname/" flake.nix

# Update hostname in configuration.nix
sed -i "s/hostName = \"caelestia-pc\"/hostName = \"${HOSTNAME}\"/" hosts/default/configuration.nix

# Update username in flake.nix (home-manager users.USERNAME)
echo -e "${GREEN}Configuring username: ${USERNAME}${NC}"
sed -i "s/users\.user = import/users.${USERNAME} = import/" flake.nix
sed -i "s/\"user\" with your username/\"${USERNAME}\" with your username/" flake.nix
sed -i "s/user@caelestia-pc/${USERNAME}@${HOSTNAME}/" flake.nix

# Update username in configuration.nix
sed -i "s/users\.users\.user/users.users.${USERNAME}/" hosts/default/configuration.nix
sed -i "s/\"user\" to your username/\"${USERNAME}\" to your username/" hosts/default/configuration.nix

# Update username in home manager config
sed -i "s/username = \"user\"/username = \"${USERNAME}\"/" modules/home/default.nix
sed -i "s|homeDirectory = \"/home/user\"|homeDirectory = \"/home/${USERNAME}\"|" modules/home/default.nix

# Create wallpaper directory
mkdir -p ~/Pictures/Wallpapers

echo ""
echo -e "${GREEN}✅ Installation complete!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  1. Review the configuration in ${CONFIG_DIR}"
echo "  2. Add a wallpaper to ~/Pictures/Wallpapers/wallpaper.jpg"
echo "  3. Update modules/home/hyprland.nix with your monitor config"
echo "  4. Update modules/home/packages.nix with your git name/email"
echo "  5. Build and switch:"
echo ""
echo -e "     ${YELLOW}nix-shell -p git --run 'sudo nixos-rebuild switch --flake ${CONFIG_DIR}#${HOSTNAME}'${NC}"
echo ""
echo -e "${BLUE}Default password:${NC} changeme (change it after login with 'passwd')"
echo ""
echo -e "${GREEN}Enjoy your new Caelestia + Hyprland setup! 🎉${NC}"
