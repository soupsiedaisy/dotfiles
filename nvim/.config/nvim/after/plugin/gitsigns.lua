require('gitsigns').setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        local function next_hunk()
            if vim.wo.diff then
                return ']c'
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return '<Ignore>'
        end

        local function prev_hunk()
            if vim.wo.diff then
                return '[c'
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return '<Ignore>'
        end

        local function stage_hunk_v()
            gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end

        local function reset_hunk_v()
            gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end

        local function blame_line()
            gs.blame_line({ full = false })
        end

        local function diff_last_commit()
            gs.diffthis('~')
        end

        map({ 'n', 'v' }, ']c', next_hunk, { expr = true, desc = 'Git jump to next hunk (gitsigns)' })
        map({ 'n', 'v' }, '[c', prev_hunk, { expr = true, desc = 'Git jump to previous hunk (gitsigns)' })
        map('v', '<leader>hs', stage_hunk_v, { desc = 'Git stage hunk (gitsigns)' })
        map('v', '<leader>hr', reset_hunk_v, { desc = 'Git reset hunk (gitsigns)' })
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'Git stage hunk (gitsigns)' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Git reset hunk (gitsigns)' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Git stage buffer (gitsigns)' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Git undo stage hunk (gitsigns)' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Git reset buffer (gitsigns)' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git preview hunk (gitsigns)' })
        map('n', '<leader>hb', blame_line, { desc = 'Git blame line (gitsigns)' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'Git diff against index (gitsigns)' })
        map('n', '<leader>hD', diff_last_commit, { desc = 'Git diff against last commit (gitsigns)' })
        map('n', '<leader>htb', gs.toggle_current_line_blame, { desc = 'Git toggle blame line (gitsigns)' })
        map('n', '<leader>htd', gs.toggle_deleted, { desc = 'Git toggle show deleted (gitsigns)' })
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Git select hunk (gitsigns)' })
    end,
})
