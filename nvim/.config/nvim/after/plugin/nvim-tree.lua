require('nvim-tree').setup({
    view = {
        number = true,
        relativenumber = true,
        side = 'right',
        width = {
            min = 20,
            max = function()
                return math.floor(vim.o.columns / 3)
            end,
            padding = 1,
        },
    },
    update_focused_file = {
        enable = true,
    },
})

vim.keymap.set({ 'n', 'v' }, '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, desc = 'Toggle tree (nvim-tree)' })
