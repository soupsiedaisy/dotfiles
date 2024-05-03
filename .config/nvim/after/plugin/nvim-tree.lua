require('nvim-tree').setup({
    view = {
        number = true,
        relativenumber = true,
    },
    update_focused_file = {
        enable = true,
    },
})

vim.keymap.set({ 'n', 'v' }, '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, desc = 'NvimTr[E]eToggle' })
