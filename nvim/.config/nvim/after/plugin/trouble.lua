require('trouble').setup({
    focus = true,
    auto_close = true,
    win = {
        type = 'split',
        position = 'right',
    },
})

vim.keymap.set(
    'n',
    '<leader>xx',
    '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
    { desc = 'Buffer Diagnostics (trouble)' }
)
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (trouble)' })
