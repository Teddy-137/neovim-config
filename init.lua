-- =============== GIGA CHAD NEOVIM CONFIG =====================

-- Basic options
local o = vim.o
o.number = true
o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.wrap = false
o.ignorecase = true
o.smartcase = true
o.cursorline = true
o.termguicolors = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.undofile = true
o.swapfile = false
o.backup = false
o.hlsearch = false
o.incsearch = true
vim.g.mapleader = " "

-- Fast saves & quits
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Movement powerups
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============== PLUGINS =====================
require("lazy").setup({
  -- THEME
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- TREESITTER
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "python", "javascript", "typescript", "html", "css" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- TELESCOPE
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
    end,
  },

  -- FILE EXPLORER
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 35 },
        renderer = { highlight_git = true, icons = { show = { git = true } } },
        filters = { dotfiles = false },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    end,
  },

  -- STATUSLINE
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ options = { theme = "tokyonight" } })
    end,
  },

  -- LSP + AUTOCOMPLETE
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls" },
        handlers = {
          function(server)
            require("lspconfig")[server].setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
          end,
        },
      })

      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Docs" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    end,
  },

  -- GIT INTEGRATION
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- COMMENTING
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },

  -- AUTO-PAIRS
  { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end },

  -- SMOOTH SCROLL
  { "karb94/neoscroll.nvim", config = function() require("neoscroll").setup() end },
})