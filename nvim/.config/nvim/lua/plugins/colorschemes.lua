return {
    { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
    { 'neanias/everforest-nvim', priority = 1000 },
    { 'navarasu/onedark.nvim', priority = 1000 },
    { 'Yazeed1s/oh-lucy.nvim', priority = 1000 },
    { 'rose-pine/neovim', priority = 1000 },
    { 'folke/tokyonight.nvim', priority = 1000 },
    {
        'EdenEast/nightfox.nvim',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('carbonfox')
        end,
    },
}
