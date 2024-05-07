-- global
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.localmapleader = ' '

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs and indents (does this still need to be here?)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- window
vim.opt.winminwidth = 10
vim.opt.winwidth = 30
vim.opt.splitright = true

-- searching
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tagcase = 'followscs'

-- undo history
vim.opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undodir'
vim.opt.undofile = true

-- misc
vim.opt.mouse = 'a'
vim.opt.scrolloff = 4
vim.opt.termguicolors = true
vim.opt.wrap = false
