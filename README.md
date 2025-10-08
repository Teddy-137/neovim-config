# Advanced Neovim Setup

This repository provides an advanced Neovim configuration using Lua, along with a setup script to install necessary dependencies. It's designed for developers who want a modern, plugin-enhanced Neovim experience with features like fuzzy finding, LSP support, autocompletion, and more.

## Features

- **Basic Editor Settings**: Line numbers, relative numbers, smart indentation, mouse support, and more.
- **Plugin Management**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for easy plugin installation and management.
- **Plugins Included**:
  - [tokyonight.nvim](https://github.com/folke/tokyonight.nvim): A beautiful theme.
  - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Enhanced syntax highlighting and indentation.
  - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): Fuzzy finder for files, grep, buffers, etc.
  - [mason.nvim](https://github.com/williamboman/mason.nvim) + [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Easy LSP server management and configuration.
  - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Autocompletion engine.
  - [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): Customizable statusline.
  - [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua): File explorer.
- **Keymaps**: Leader key set to space. Includes shortcuts for saving/quitting, Telescope searches, LSP actions, file explorer, and line moving.
- **Additional Options**: System clipboard integration, persistent undo, no swap/backup files, centered scrolling, etc.

## Prerequisites

- Neovim v0.8 or later.
- Git (for cloning plugins).
- A Unix-like system (the setup script is tailored for Debian-based distros like Ubuntu; adjust for others).

## Installation

1. **Clone this Repository** (optional, if you're using this as a base):
   ```
   git clone https://github.com/yourusername/advanced-neovim-setup.git ~/.config/nvim
   ```

2. **Run the Setup Script**:
   The `run.sh` script installs essential packages. Make it executable and run it:
   ```
   chmod +x run.sh
   ./run.sh
   ```
   This will install:
   - Neovim (if not present).
   - Git, Node.js/npm, Python3/pip.
   - ripgrep and fd-find (for Telescope).
   - Build essentials and other tools.

   **Note**: Run with `sudo` if prompted for permissions. For non-Debian systems, install equivalents manually (e.g., via Homebrew on macOS or yum on Fedora).

3. **Copy Configuration**:
   Ensure `init.lua` is in `~/.config/nvim/init.lua`. If using the provided file, it will bootstrap lazy.nvim and install plugins on first launch.

4. **Launch Neovim**:
   Open Neovim with `nvim`. Plugins will install automatically via lazy.nvim. Restart Neovim if needed.

## Configuration Files

- **`init.lua`**: Main configuration file. Includes all settings, plugin setups, and keymaps.
- **`run.sh`**: Bash script for dependency installation.

## Keymaps

- `<leader>w`: Save file (`:w<CR>`).
- `<leader>q`: Quit (`:q<CR>`).
- `<leader>ff`: Find files (Telescope).
- `<leader>fg`: Live grep (Telescope).
- `<leader>fb`: Buffers (Telescope).
- `<leader>e`: Toggle file explorer (NvimTree).
- `gd`: Go to definition (LSP).
- `K`: Hover documentation (LSP).
- `<leader>ca`: Code actions (LSP).
- `<leader>pv`: Open netrw explorer.
- `J` / `K` (visual mode): Move selected lines down/up.
- `<C-d>` / `<C-u>`: Half-page scroll with cursor centered.

## Customization

- Add more languages to Treesitter or Mason by editing the `ensure_installed` lists in `init.lua`.
- Extend plugins in the `lazy.setup` table.
- Adjust theme or options as needed.

## Troubleshooting

- **Plugins not installing?** Ensure Git is installed and run `nvim` again.
- **LSP not working?** Check if servers are installed via `:Mason`.
- **Errors on startup?** Run `:Lazy sync` or check `:checkhealth`.
