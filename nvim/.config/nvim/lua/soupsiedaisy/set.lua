-- global
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.localmapleader = ' '
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- tabs and indents (does this still need to be here?)
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- window
vim.o.winminwidth = 10
vim.o.winwidth = 30
vim.o.splitright = true

-- searching
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.tagcase = 'followscs'

-- undo history
vim.o.undodir = os.getenv('HOME') .. '/.cache/nvim/undodir'
vim.o.undofile = true

-- misc
vim.o.mouse = 'a'
vim.o.scrolloff = 4
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.foldlevelstart = 999
