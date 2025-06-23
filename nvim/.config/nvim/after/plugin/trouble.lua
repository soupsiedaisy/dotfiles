require('trouble').setup({
    focus = true,
    win = {
        type = 'float',
        relative = 'editor',
        border = 'rounded',
        position = { 0, -2 },
        size = { width = 0.3, height = 0.3 },
        zindex = 200,
    },
})

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set(
    'n',
    '<leader>xX',
    '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
    { desc = 'Buffer Diagnostics (Trouble)' }
)
