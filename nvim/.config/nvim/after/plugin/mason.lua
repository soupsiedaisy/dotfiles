local on_attach = function(_, bufnr)
    local nmap = function(keys, desc, func)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    local listWorkspaceFolders = function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end

    nmap('<leader>rn', '[R]e[n]ame', vim.lsp.buf.rename)
    nmap('<leader>ca', '[C]ode [A]ction', vim.lsp.buf.code_action)
    nmap('<leader>D', 'Type [D]efinition', require('telescope.builtin').lsp_type_definitions)
    nmap('<leader>ds', '[D]ocument [S]ymbols', require('telescope.builtin').lsp_document_symbols)
    nmap('<leader>ws', '[W]orkspace [S]ymbols', require('telescope.builtin').lsp_dynamic_workspace_symbols)
    nmap('<leader>wa', '[W]orkspace [A]dd Folder', vim.lsp.buf.add_workspace_folder)
    nmap('<leader>wr', '[W]orkspace [R]emove Folder', vim.lsp.buf.remove_workspace_folder)
    nmap('<leader>wl', '[W]orkspace [L]ist Folders', listWorkspaceFolders)
    nmap('gD', '[G]oto [D]eclaration', vim.lsp.buf.declaration)
    nmap('gd', '[G]oto [D]efinition', require('telescope.builtin').lsp_definitions)
    nmap('gr', '[G]oto [R]eferences', require('telescope.builtin').lsp_references)
    nmap('gI', '[G]oto [I]mplementation', require('telescope.builtin').lsp_implementations)
    nmap('K', 'Hover Documentation', vim.lsp.buf.hover)
    nmap('<C-k>', 'Signature Documentation', vim.lsp.buf.signature_help)
end

require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
    eslint = {},
    lua_ls = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require',
                },
            },
            telemetry = { enable = false },
        },
    },
    ts_ls = {},
    taplo = {},
    omnisharp = {},
    somesass_ls = {},
}

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_enable = true,
})

for server in pairs(servers) do
    vim.lsp.config(server, {
        settings = servers[server],
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = (servers[server] or {}).filetypes,
    })
end
