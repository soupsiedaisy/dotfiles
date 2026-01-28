require('nvim-tree').setup({
    view = {
        number = true,
        relativenumber = true,
        centralize_selection = true,
        float = {
            enable = true,
            open_win_config = function()
                local columns = vim.o.columns
                local lines = vim.o.lines
                local divisor = 4

                return {
                    relative = 'editor',
                    border = 'rounded',
                    width = math.floor(columns / divisor),
                    height = lines > 10 and lines - 7 or lines,
                    row = 2,
                    col = math.floor(columns * (divisor - 1) / divisor),
                    title = {
                        { ' nvim-tree ', 'FloatBorder' },
                    },
                    title_pos = 'center',
                }
            end,
        },
    },
    diagnostics = {
        enable = true,
        severity = {
            min = vim.diagnostic.severity.WARN
        }
    },
    update_focused_file = {
        enable = true,
    },
})

vim.keymap.set({ 'n', 'v' }, '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, desc = 'Toggle tree (nvim-tree)' })
