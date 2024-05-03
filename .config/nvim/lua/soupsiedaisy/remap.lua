-- ALT+{h,j,k,l} to navigate windows
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true, desc = 'Go to the left window' })
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true, desc = 'Go to the down window' })
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true, desc = 'Go to the up window' })
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true, desc = 'Go to the right window' })
vim.keymap.set('n', '<A-h>', '<C-w>h', { noremap = true, desc = 'Go to the left window' })
vim.keymap.set('n', '<A-j>', '<C-w>j', { noremap = true, desc = 'Go to the down window' })
vim.keymap.set('n', '<A-k>', '<C-w>k', { noremap = true, desc = 'Go to the up window' })
vim.keymap.set('n', '<A-l>', '<C-w>l', { noremap = true, desc = 'Go to the right window' })

-- CTRL+` {t,`,h,j,k,l} to open terminal (a bit hacky, but preserves split config)
-- TODO review hacky-ness
vim.keymap.set('n', '<C-`>t', ':tabnew +terminal<CR>', { noremap = true, desc = 'Terminal: new terminal in new tab' })
vim.keymap.set('n', '<C-`>`', vim.cmd.terminal, { noremap = true, desc = 'Terminal: new terminal in current buffer' })
vim.keymap.set('n', '<C-`>h', function()
    local cur = vim.o.splitright
    vim.o.splitright = false
    vim.cmd.vsplit()
    vim.cmd.terminal()
    vim.o.splitright = cur
end, { noremap = true, desc = 'Terminal: new terminal to the left' })
vim.keymap.set('n', '<C-`>j', function()
    local cur = vim.o.splitbelow
    vim.o.splitbelow = true
    vim.cmd.split()
    vim.cmd.terminal()
    vim.o.splitbelow = cur
end, { noremap = true, desc = 'Terminal: new terminal downwards' })
vim.keymap.set('n', '<C-`>k', function()
    local cur = vim.o.splitbelow
    vim.o.splitbelow = false
    vim.cmd.split()
    vim.cmd.terminal()
    vim.o.splitbelow = cur
end, { noremap = true, desc = 'Terminal: new terminal upwards' })
vim.keymap.set('n', '<C-`>l', function()
    local cur = vim.o.splitright
    vim.o.splitright = true
    vim.cmd.vsplit()
    vim.cmd.terminal()
    vim.o.splitright = cur
end, { noremap = true, desc = 'Terminal: new terminal to the right' })
