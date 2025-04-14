require('lualine').setup({
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
    },
    sections = {
        lualine_c = { "vim.fn.expand('%')" },
    },
})
