require('lualine').setup({
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = { 'NvimTree' },
    },
    tabline = {
        lualine_a = { { 'tabs', mode = 1 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { { 'filename', path = 1, file_status = false } },
        lualine_y = {},
        lualine_z = {},
    },
})
