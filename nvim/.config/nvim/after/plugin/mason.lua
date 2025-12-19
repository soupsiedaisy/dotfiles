local mason = require('mason')
local mason_registry = require('mason-registry')
local telescope_builtin = require('telescope.builtin')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local mason_lspconfig = require('mason-lspconfig')
local typescript_tools = require('typescript-tools')

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
    nmap('gd', 'Goto definition', telescope_builtin.lsp_definitions)
    nmap('gr', 'Goto references', telescope_builtin.lsp_references)
    nmap('gI', 'Goto implementation', telescope_builtin.lsp_implementations)
    nmap('K', 'Hover documentation', vim.lsp.buf.hover)
    nmap('<C-k>', 'Signature documentation', vim.lsp.buf.signature_help)
    nmap('<leader>lr', 'Rename', vim.lsp.buf.rename)
    nmap('<leader>la', 'Code action', vim.lsp.buf.code_action)
    nmap('<leader>lD', 'Type definition', telescope_builtin.lsp_type_definitions)
    nmap('<leader>ls', 'Document symbols', telescope_builtin.lsp_document_symbols)
    nmap('<leader>lws', 'Workspace symbols', telescope_builtin.lsp_dynamic_workspace_symbols)
    nmap('<leader>lwa', 'Workspace add folder', vim.lsp.buf.add_workspace_folder)
    nmap('<leader>lwr', 'Workspace remove folder', vim.lsp.buf.remove_workspace_folder)
    nmap('<leader>lwl', 'Workspace list folders', listWorkspaceFolders)
end

local language_servers = {
    clangd = {},
    eslint = {},
    harper_ls = {},
    html = {},
    jsonls = {},
    lua_ls = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require',
                    'package',
                },
            },
            telemetry = { enable = false },
        },
    },
    pylsp = {},
    somesass_ls = {},
    stylua = {},
    taplo = {},
    ts_ls = {},
}

local linters = {
    'markdownlint',
    'prettier',
    'eslint_d',
    'prettierd',
}

mason.setup()

for _, linter in pairs(linters) do
    local package = mason_registry.get_package(linter)

    if package.is_installable(package) and not package.is_installed(package) then
        package.install(package)
    end
end

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(language_servers),
    automatic_enable = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

for server, config in pairs(language_servers) do
    vim.lsp.config(server, {
        settings = config,
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = config.filetypes,
    })
end

-- TODO integrate with ts_ls
typescript_tools.setup({
    settings = {
        tsserver_plugins = {
            '@styled/typescript-styled-plugin',
        },
    },
    capabilities = capabilities,
    on_attach = on_attach,
})
