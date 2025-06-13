local prettier = { 'prettierd', 'prettier', stop_after_first = true }

require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        javascript = prettier,
        typescript = prettier,
        javascriptreact = prettier,
        typescriptreact = prettier,
        css = prettier,
        html = prettier,
        json = prettier,
        yaml = prettier,
        graphql = prettier,
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
