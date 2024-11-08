require("solarized-osaka").setup({
    -- on_highlights = function(hl, c)
    --     hl.TelescopeBorder = {
    --         bg = c.bg_dark,
    --         fg = c.bg_dark,
    --     }
    --     hl.TelescopePreviewTitle = {
    --         bg = c.bg_dark,
    --         fg = c.bg_dark,
    --     }
    --     hl.TelescopeResultsTitle = {
    --         bg = c.bg_dark,
    --         fg = c.bg_dark,
    --     }
    -- end,
    transparent = false,  -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "normal", -- style for floating windows
    },
})
-- Initialize an augroup to manage the autocommand
local augroup = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })

-- Create the autocommand for the ColorScheme event
vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroup,
    pattern = "*",
    command = "hi NvimTreeNormalNC guibg=NONE",
})

-- lvim.autocommands = {
--    -- other commands,
--    {
--      "ColorScheme",
--      { command = "hi NvimTreeNormalNC guibg=NONE" }
--    }
-- }
vim.cmd([[colorscheme solarized-osaka-storm]])
vim.cmd("set cursorline")
