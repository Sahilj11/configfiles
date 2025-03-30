local luasnip = require("luasnip")
local cmp = require("cmp")
luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

cmp.setup({
    view = {
        docs = {
            auto_open = false,
        },
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if luasnip.expand() then
                    luasnip.expand()
                else
                    cmp.confirm({
                        select = true,
                    })
                end
            else
                fallback()
            end
        end),
        ["<c-k>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-g>"] = function()
            if cmp.visible_docs() then
                cmp.close_docs()
            else
                cmp.open_docs()
            end
        end,
        ["<c-j>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp", max_item_count = 200 },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = "luasnip" }, -- For luasnip users.
        { name = "path" },
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = "buffer" },
    }),
})
vim.keymap.set({ "i", "s" }, "<c-e>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, { silent = true })
-- cmp.setup({
--     enabled = function()
--         return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
--         or require("cmp_dap").is_dap_buffer()
--     end
-- })
--
-- cmp.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
--     sources = {
--         { name = "dap" },
--     },
-- })
require("vim-react-snippets").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load()
-- require("luasnip").filetype_extend("javascript", { "javascriptreact" })
-- require("luasnip").filetype_extend("javascript", { "html" })
