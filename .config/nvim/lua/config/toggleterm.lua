require("toggleterm").setup({
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true,   -- if set to true (default) the previous terminal mode will be remembered
    direction = "float",
    close_on_exit = true,
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        border = "curved",
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "tab" })
function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>ge", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
