local wk = require("which-key")

wk.add({
    { "<leader>a",   "^",                              desc = "Go to start of line" },
    { "<leader>b",   "<C-w>s",                         desc = "Horizontal split" },
    { "<leader>d",   "$",                              desc = "Go to end of line" },
    { "<leader>e",   ":NvimTreeToggle<cr>",            desc = "Open Explorer" },
    { "<leader>g",   group = "git" },
    { "<leader>gb",  "<cmd>Gitsigns blame_line<cr>",   desc = "Blame line" },
    { "<leader>gd",  "<cmd>Gitsigns diffthis<cr>",     desc = "Get Diff" },
    { "<leader>gp",  "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    { "<leader>gr",  group = "Reset" },
    { "<leader>grb", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset buffer" },
    { "<leader>grh", "<cmd>Gitsigns reset_hunk<cr>",   desc = "Reset hunk" },
    { "<leader>gs",  "<cmd>Gitsigns stage_hunk<cr>",   desc = "Stage hunk" },
    { "<leader>gt",  "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage buffer" },
    { "<leader>h",   "<C-w>h",                         desc = "Jump left pane" },
    { "<leader>j",   "<C-w>j",                         desc = "Jump down pane" },
    { "<leader>k",   "<C-w>k",                         desc = "Jump up pane" },
    { "<leader>l",   "<C-w>l",                         desc = "Jump right pane" },
    { "<leader>v",   "<C-w>v",                         desc = "Vertical split" },
    { "<leader>y",   group = "Clipboard actions" },
    { "<leader>yp",  '"+P',                            desc = "Past from Clipboard" },
    { "<leader>yy",  '"+yy',                           desc = "Copy whole line" },
    { "<leader>t",   group = "Trouble" },
    { "<leader>ts",  "<cmd>Trouble symbols<cr>",       desc = "LSP Symbols" },
    { "<leader>tc",  "<cmd>HighlightColors Toggle<cr>" },
    { "<leader>te",  "<cmd>Trouble diagnostics<cr>" },
    { "<leader>td",  "<cmd>Trouble todo<cr>" },
})

-- wk.register({
--     g = {
--         name = "git",
--         b = { "<cmd>Gitsigns blame_line<cr>", "Blame line" },
--         t = {"<cmd>Gitsigns stage_buffer<cr>", "Stage buffer"},
--         r = {
--             name = "Reset",
--             b = {"<cmd>Gitsigns reset_buffer<cr>", "Reset buffer"},
--             h = {"<cmd>Gitsigns reset_hunk<cr>", "Reset hunk"}
--         },
--         p={ "<cmd>Gitsigns preview_hunk<cr>", "Preview hunk"},
--         s={ "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk"},
--         d={ "<cmd>Gitsigns diffthis<cr>", "Get Diff"}
--     },
--     y={
--         name = "Clipboard actions",
--         y={'"+yy',"Copy whole line" },
--         p={ '"+P',"Past from Clipboard"},
--     },
--     v = { "<C-w>v", "Vertical split"},
--     b = { "<C-w>s", "Horizontal split" },
--     h = { "<C-w>h", "Jump left pane" },
--     j = { "<C-w>j", "Jump down pane" },
--     k = { "<C-w>k", "Jump up pane" },
--     l = { "<C-w>l", "Jump right pane" },
--     e={":NvimTreeToggle<cr>", "Open Explorer"},
--     d={ "$", "Go to end of line"},
--     a={ "^", "Go to start of line"}
-- }, { prefix = "<leader>" })

-- Key mapping to call the function
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>FzfLua files<CR>", { noremap = true, silent = true })
