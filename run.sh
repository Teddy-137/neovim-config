#!/bin/bash
set -e

# =============== GIGA CHAD NEOVIM INSTALLER ==================
# Works on Debian/Ubuntu systems

# Colors
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${CYAN}🚀 Starting Giga Chad Neovim setup...${RESET}"

# -------------------------
echo -e "${YELLOW}🔹 Updating package list...${RESET}"
sudo apt update -y

# -------------------------
echo -e "${YELLOW}🔹 Installing essential packages...${RESET}"
sudo apt install -y git curl unzip build-essential software-properties-common

# -------------------------
echo -e "${YELLOW}🔹 Installing Neovim...${RESET}"
if ! command -v nvim &>/dev/null; then
  sudo apt install -y neovim
else
  echo -e "${GREEN}✔ Neovim already installed.${RESET}"
fi

# -------------------------
echo -e "${YELLOW}🔹 Installing Node.js (for LSPs & plugins)...${RESET}"
if ! command -v node &>/dev/null; then
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt install -y nodejs
else
  echo -e "${GREEN}✔ Node.js already installed.${RESET}"
fi

# -------------------------
echo -e "${YELLOW}🔹 Installing Python3 and pip...${RESET}"
sudo apt install -y python3 python3-pip

# -------------------------
echo -e "${YELLOW}🔹 Installing ripgrep and fd-find (for Telescope)...${RESET}"
sudo apt install -y ripgrep fd-find

# fd-find installs as fdfind, so link it to fd if not present
if ! command -v fd &>/dev/null; then
  sudo ln -sf $(which fdfind) /usr/local/bin/fd
fi

# -------------------------
echo -e "${YELLOW}🔹 Installing Lua (for Neovim runtime)...${RESET}"
sudo apt install -y lua5.3

# -------------------------
echo -e "${YELLOW}🔹 Setting up Neovim config...${RESET}"
NVIM_DIR="$HOME/.config/nvim"
mkdir -p "$NVIM_DIR"

# Option A: If you already have init.lua in the same folder as this script
if [ -f "./init.lua" ]; then
  cp ./init.lua "$NVIM_DIR/init.lua"
  echo -e "${GREEN}✔ Copied local init.lua to $NVIM_DIR${RESET}"
else
  # Option B: Clone from GitHub if you have a repo for your config
  # Replace the following line with your actual config repo URL
  echo -e "${YELLOW}No local init.lua found. You can copy your config manually to $NVIM_DIR/init.lua${RESET}"
fi

# -------------------------
echo -e "${YELLOW}🔹 Ensuring permissions and environment...${RESET}"
sudo chown -R "$USER":"$USER" "$NVIM_DIR"

# -------------------------
echo -e "${GREEN}✅ Installation complete!${RESET}"
echo -e "${CYAN}Run ${YELLOW}nvim${CYAN} and let lazy.nvim install your plugins automatically.${RESET}"
echo -e "${CYAN}Once loaded, you’ll have the full Giga Chad setup with LSPs, Telescope, Tree, Git, and more.${RESET}"
