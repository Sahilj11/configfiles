require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer" },
})
local Capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Setup language servers.
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").lua_ls.setup({
    capabilities = Capabilities,
})
require("lspconfig").phpactor.setup({
    capabilities = Capabilities,
})
require("lspconfig").gopls.setup({
    capabilities = Capabilities,
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
})
require("lspconfig").tsserver.setup({
    capabilities = Capabilities,
})
require("lspconfig").lemminx.setup({
    capabilities = Capabilities,
})
require("lspconfig").emmet_language_server.setup({
    capabilities = Capabilities,
    filetypes = {
        "css",
        "eruby",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "typescript",
        "scss",
        "svelte",
        "pug",
        "typescriptreact",
        "vue",
        "php",
    },
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
            },
        },
    },
})
require("lspconfig").pyright.setup({
    capabilities = Capabilities,
})
require("lspconfig").slint_lsp.setup({
    capabilities = Capabilities,
    cmd = {
        "slint-lsp",
    },
    filetypes = {
        "slint",
    },
})
require("lspconfig").rust_analyzer.setup({
    -- Server-specific settings. See `:help lspconfig-setup`
    capabilities = Capabilities,
    cmd = {
        "rustup",
        "run",
        "stable",
        "rust-analyzer",
    },
    settings = {
        ["rust-analyzer"] = {},
    },
})
require("lspconfig").cssls.setup({
    capabilities = capabilities,
})
require("lspconfig").html.setup({
    capabilities = capabilities,
})

local nvim_lsp = require("lspconfig")

-- Function to attach LSP to current buffer

function attach_lsp_to_buffer()
    nvim_lsp.htmx.setup({})
end

-- require("lspconfig").htmx.setup({})
require("lspconfig").clangd.setup({
    capabilities = Capabilities,
})
require("lspconfig").tailwindcss.setup({
    root_dir = function(fname)
        local root_pattern =
            require("lspconfig").util.root_pattern("tailwind.config.cjs", "tailwind.config.js", "postcss.config.js")
        return root_pattern(fname)
    end,
})
-- null-ls
local null_ls = require("null-ls")
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    -- function to format on save
    -- on_attach = function(client, bufnr)
    -- 	-- if client.supports_method("textDocument/formatting") then
    -- 	-- 	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    -- 	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
    -- 	-- 		group = augroup,
    -- 	-- 		buffer = bufnr,
    -- 	-- 		callback = function()
    -- 	-- 			vim.lsp.buf.format({ async = false })
    -- 	-- 		end,
    -- 	-- 	})
    -- 	-- end
    -- 	client.server_capabilities.semanticTokensProvider = nil
    -- end,
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.google_java_format,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.phpcsfixer,
        null_ls.builtins.formatting.clang_format,
        -- null_ls.builtins.code_actions.eslint_d,
        -- null_ls.builtins.code_actions.eslint,
        -- null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.checkstyle.with({
            extra_args = { "-c", "/home/sahil/google_checkstyle.xml" }, -- or "/sun_checks.xml" or path to self written rules
        }),
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.prettier,
    },
})
require("mason-null-ls").setup({
    ensure_installed = {
        "stylua",
        "jq",
        "eslint_d",
        "prettier",
        "black",
        "jdtls",
        "pyright",
        "phpactor",
        "cssls",
        "html",
        "clangd",
        "tsserver",
        "tailwindcss",
        "emmet_language_server",
        "lemminx",
    },
})
