vim.api.nvim_create_autocmd('TermOpen', { command = 'setlocal nonumber norelativenumber' })

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    command = 'wincmd L',
})
