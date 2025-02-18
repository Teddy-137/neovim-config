-- Basic Options
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.splitright = true
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.updatetime = 50

-- Leader Key
vim.g.mapleader = ' '

-- Key Mappings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>q', ':q<CR>', opts)

-- Split navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Packer Plugin Manager
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    -- Package Manager
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'olimorris/onedarkpro.nvim'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    
    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- Additional Quality of Life Plugins
    use 'windwp/nvim-autopairs'
    use 'numToStr/Comment.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- Theme Configuration
require('onedarkpro').setup({
    theme = 'onedark',
    colors = {
        bg = '#1e222a'
    },
    options = {
        transparent = false,
        terminal_colors = true,
        bold = true,
        italic = true,
        underline = true,
        cursorline = true,
    }
})

vim.cmd([[colorscheme onedarkpro]])

-- Plugin Configurations
require('nvim-autopairs').setup{}
require('Comment').setup{}
require('lualine').setup{
    options = {
        theme = 'onedark'
    }
}

-- Treesitter Configuration
require('nvim-treesitter.configs').setup{
    ensure_installed = {
        'lua', 'vim', 'javascript', 'typescript', 'python',
        'html', 'css', 'json', 'markdown'
    },
    highlight = {
        enable = true,
    },
}

-- Basic LSP Configuration
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP Keybindings
local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
    keymap('n', 'K', vim.lsp.buf.hover, bufopts)
    keymap('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    keymap('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end

-- Completion Configuration
local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
    })
})