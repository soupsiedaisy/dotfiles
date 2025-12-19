local conform = require('conform')
local common = { 'eslint_d', 'prettierd', 'prettier', stop_after_first = true }

conform.setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        javascript = common,
        typescript = common,
        javascriptreact = common,
        typescriptreact = common,
        css = common,
        html = common,
        json = common,
        yaml = common,
        graphql = common,
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
    conform.format({ async = true, lsp_fallback = true })
end, { desc = 'Format buffer' })
