require('which-key').add({
   {
        '<leader>?',
        function()
            require('which-key').show({ global = false })
        end,
        desc = 'Buffer local keymaps (which-key)',
    },
    { '<leader>l', group = 'LSP', icon = { cat = 'filetype', name = 'lua' } },
    { '<leader>lw', group = 'Workspace' },
    { '<leader>h', group = 'Hunk', icon = { cat = 'extension', name = 'git' } },
    { '<leader>s', group = 'Search', icon = { desc = 'telescope' } },
    { '<leader>x', group = 'Diagnostics' },
    { '<leader>`', group = 'Terminal' },
})
