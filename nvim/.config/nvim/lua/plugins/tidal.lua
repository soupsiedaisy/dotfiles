return {
    'grddavies/tidal.nvim',
    ft = 'tidal',
    opts = {
        boot = {
            tidal = {
                cmd = 'ghci',
                args = {
                    '-v0',
                },
                enabled = true,
            },
            sclang = {
                cmd = 'sclang',
                args = {},
                enabled = true,
            },
            split = 'v',
        },
        mappings = {
            send_line = { mode = { 'i', 'n' }, key = '<S-CR>' },
            send_visual = { mode = { 'x' }, key = '<S-CR>' },
            send_block = { mode = { 'i', 'n', 'x' }, key = '<C-CR>' },
            send_node = { mode = { 'i', 'n', 'x' }, key = '<M-CR>' },
            send_silence = { mode = 'n', key = '<leader>td' },
            send_hush = { mode = 'n', key = '<leader>th' },
        },
        selection_highlight = {
            highlight = { link = 'IncSearch' },
            timeout = 150,
        },
    },
}
