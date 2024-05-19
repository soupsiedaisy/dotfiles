require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { { 'prettierd', 'prettier' } },
        markdown = { 'markdownlint' },
    },

    -- format_on_save = { timeout_ms = 500, lsp_fallback = true },

    formatters = {
        shfmt = {
            prepend_args = { '-i', '2' },
        },
    },
})

vim.keymap.set('n', '<leader>f', function()
    require('conform').format({ async = true, lsp_fallback = true })
end, { desc = 'Format buffer' })
