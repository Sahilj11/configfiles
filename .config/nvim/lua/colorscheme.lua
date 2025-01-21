-- require("solarized-osaka").setup({
--     -- on_highlights = function(hl, c)
--     --     hl.TelescopeBorder = {
--     --         bg = c.bg_dark,
--     --         fg = c.bg_dark,
--     --     }
--     --     hl.TelescopePreviewTitle = {
--     --         bg = c.bg_dark,
--     --         fg = c.bg_dark,
--     --     }
--     --     hl.TelescopeResultsTitle = {
--     --         bg = c.bg_dark,
--     --         fg = c.bg_dark,
--     --     }
--     -- end,
--     transparent = false,  -- Enable this to disable setting the background color
--     terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
--     styles = {
--         -- Style to be applied to different syntax groups
--         -- Value is any valid attr-list value for `:help nvim_set_hl`
--         comments = { italic = true },
--         keywords = { italic = true },
--         functions = {},
--         variables = {},
--         -- Background styles. Can be "dark", "transparent" or "normal"
--         sidebars = "transparent", -- style for sidebars, see below
--         floats = "normal", -- style for floating windows
--     },
-- })
-- -- Initialize an augroup to manage the autocommand
-- local augroup = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })
--
-- -- Create the autocommand for the ColorScheme event
-- vim.api.nvim_create_autocmd("ColorScheme", {
--     group = augroup,
--     pattern = "*",
--     command = "hi NvimTreeNormalNC guibg=NONE",
-- })

-- lvim.autocommands = {
--    -- other commands,
--    {
--      "ColorScheme",
--      { command = "hi NvimTreeNormalNC guibg=NONE" }
--    }
-- }
-- vim.cmd([[colorscheme rose-pine-moon]])
vim.cmd("set cursorline")
-- Default options:
require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "soft", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")
