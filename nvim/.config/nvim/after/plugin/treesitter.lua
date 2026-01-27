local ensure_installed = {
    'awk',
    'bash',
    'c',
    'cmake',
    'comment',
    'cpp',
    'css',
    'desktop',
    'diff',
    'editorconfig',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'haskell',
    'haskell_persistent',
    'html',
    'html_tags',
    'java',
    'javadoc',
    'javascript',
    'jsdoc',
    'json',
    'jsx',
    'kitty',
    'lua',
    'luadoc',
    'make',
    'markdown',
    'markdown_inline',
    'objdump',
    'passwd',
    'powershell',
    'printf',
    'python',
    'query',
    'regex',
    'robot',
    'robots_txt',
    'scss',
    'sql',
    'ssh_config',
    'strace',
    'supercollider',
    'tmux',
    'todotxt',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
    'zsh',
}

require('nvim-treesitter').install(ensure_installed)

vim.api.nvim_create_autocmd('FileType', {
    pattern = ensure_installed,
    callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
    end,
})

