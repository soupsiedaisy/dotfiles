require('lualine').setup({
    options = {
        icons_enabled = false,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
    },
    sections = {
        lualine_c = { "vim.fn.expand('%')" },
    },
})
