#!/bin/bash

echo "Updating package list..."
sudo apt update

echo "Installing Neovim (if not already installed)..."
sudo apt install -y neovim

echo "Installing Git (required for plugin manager)..."
sudo apt install -y git

echo "Installing Node.js and npm (for LSP servers)..."
sudo apt install -y nodejs npm

echo "Installing Python3 and pip (for Python LSP)..."
sudo apt install -y python3 python3-pip

echo "Installing ripgrep (for Telescope live_grep)..."
sudo apt install -y ripgrep

echo "Installing fd-find (for Telescope find_files)..."
sudo apt install -y fd-find

echo "Installing additional tools for Treesitter and other plugins..."
# For building Treesitter parsers, need build essentials
sudo apt install -y build-essential

sudo apt install -y lua5.3

sudo apt install -y unzip curl

echo "Setting up Neovim config..."
mkdir -p ~/.config/nvim
echo "Please copy the provided Lua config to ~/.config/nvim/init.lua"

echo "Installation complete! Run nvim to bootstrap plugins."