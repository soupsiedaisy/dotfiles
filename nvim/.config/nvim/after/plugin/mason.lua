local on_attach = function(_, bufnr)
    local nmap = function(keys, desc, func)
        if desc then
            desc = desc .. ' (lsp)'
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    local listWorkspaceFolders = function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end

    nmap('gD', 'Goto declaration', vim.lsp.buf.declaration)
    nmap('gd', 'Goto definition', require('telescope.builtin').lsp_definitions)
    nmap('gr', 'Goto references', require('telescope.builtin').lsp_references)
    nmap('gI', 'Goto implementation', require('telescope.builtin').lsp_implementations)
    nmap('K', 'Hover documentation', vim.lsp.buf.hover)
    nmap('<C-k>', 'Signature documentation', vim.lsp.buf.signature_help)
    nmap('<leader>lr', 'Rename', vim.lsp.buf.rename)
    nmap('<leader>la', 'Code action', vim.lsp.buf.code_action)
    nmap('<leader>lD', 'Type definition', require('telescope.builtin').lsp_type_definitions)
    nmap('<leader>ls', 'Document symbols', require('telescope.builtin').lsp_document_symbols)
    nmap('<leader>lws', 'Workspace symbols', require('telescope.builtin').lsp_dynamic_workspace_symbols)
    nmap('<leader>lwa', 'Workspace add folder', vim.lsp.buf.add_workspace_folder)
    nmap('<leader>lwr', 'Workspace remove folder', vim.lsp.buf.remove_workspace_folder)
    nmap('<leader>lwl', 'Workspace list folders', listWorkspaceFolders)
end

require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
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
    eslint = {},
    harper_ls = {},
    html = {},
    jsonls = {},
    pylsp = {},
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
