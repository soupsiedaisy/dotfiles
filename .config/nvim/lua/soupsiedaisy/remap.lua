-- ALT+{h,j,k,l} to navigate windows
vim.keymap.set({ 't', 'i', 'n' }, '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true, desc = 'Go to the left window' })
vim.keymap.set({ 't', 'i', 'n' }, '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true, desc = 'Go to the down window' })
vim.keymap.set({ 't', 'i', 'n' }, '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true, desc = 'Go to the up window' })
vim.keymap.set({ 't', 'i', 'n' }, '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true, desc = 'Go to the right window' })

-- ALT+` {`,t,h,j,k,l} to open terminal
vim.keymap.set('n', '<A-`>`', vim.cmd.terminal, { noremap = true, desc = 'Terminal: new terminal in current buffer' })
vim.keymap.set('n', '<A-`>t', ':tabnew +terminal<CR>', { noremap = true, desc = 'Terminal: new terminal in new tab' })
vim.keymap.set('n', '<A-`>h', ':vertical leftabove terminal<CR>', { noremap = true, desc = 'Terminal: new terminal to the left' })
vim.keymap.set('n', '<A-`>j', ':rightbelow terminal<CR>', { noremap = true, desc = 'Terminal: new terminal downwards' })
vim.keymap.set('n', '<A-`>k', ':leftabove terminal<CR>', { noremap = true, desc = 'Terminal: new terminal upwards' })
vim.keymap.set('n', '<A-`>l', ':vertical rightbelow terminal<CR>', { noremap = true, desc = 'Terminal: new terminal to the right' })
