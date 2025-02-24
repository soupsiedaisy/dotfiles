require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = ''
    },
    sections = {
        lualine_c = { "vim.fn.expand('%')" }
    }
};
