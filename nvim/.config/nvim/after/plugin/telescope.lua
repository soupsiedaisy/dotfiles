local telescope = require('telescope')
local telescopeBuiltin = require('telescope.builtin')
local telescopeThemes = require('telescope.themes')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
})

pcall(telescope.load_extension, 'fzf')

local function find_git_root()
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    if current_file == '' then
        current_dir = cwd
    else
        current_dir = vim.fn.fnamemodify(current_file, ':h')
    end

    local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
    if vim.v.shell_error ~= 0 then
        print('Not a git repository. Searching on current working directory')
        return cwd
    end
    return git_root
end

local function fuzzy_find_current_buffer()
    telescopeBuiltin.current_buffer_fuzzy_find(telescopeThemes.get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end

local function telescope_live_grep_open_files()
    telescopeBuiltin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    })
end

local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        telescopeBuiltin.live_grep({
            search_dirs = { git_root },
            prompt_title = 'Live Grep on Git Root',
        })
    end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

vim.keymap.set('n', '<leader>/', fuzzy_find_current_buffer, { desc = 'Search fuzzy in current buffer (telescope)' })
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = 'Search in open files (telescope)' })
vim.keymap.set('n', '<leader>?', telescopeBuiltin.oldfiles, { desc = 'Find recently opened files (telescope)' })
vim.keymap.set('n', '<leader><space>', telescopeBuiltin.buffers, { desc = 'Find existing buffers (telescope)' })
vim.keymap.set('n', '<leader>ss', telescopeBuiltin.builtin, { desc = 'Search select telescope (telescope)' })
vim.keymap.set('n', '<leader>sf', telescopeBuiltin.git_files, { desc = 'Search files in git root (telescope)' })
vim.keymap.set('n', '<leader>sF', telescopeBuiltin.find_files, { desc = 'Search files in working directory (telescope)' })
vim.keymap.set('n', '<leader>sh', telescopeBuiltin.help_tags, { desc = 'Search help (telescope)' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', telescopeBuiltin.grep_string, { desc = 'Search current word (telescope)' })
vim.keymap.set('n', '<leader>sG', telescopeBuiltin.live_grep, { desc = 'Search by grep (telescope)' })
vim.keymap.set('n', '<leader>sg', ':LiveGrepGitRoot<cr>', { desc = 'Search by grep on git root (telescope)' })
vim.keymap.set('n', '<leader>sd', telescopeBuiltin.diagnostics, { desc = 'Search Diagnostics (telescope)' })
vim.keymap.set('n', '<leader>sr', telescopeBuiltin.resume, { desc = 'Search resume (telescope)' })
