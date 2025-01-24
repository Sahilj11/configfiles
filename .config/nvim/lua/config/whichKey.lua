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
    { "<leader>tc",  "<cmd>HighlightColors Toggle<cr>" },
    { "<leader>td",  "<cmd>Trouble todo<cr>" ,desc="TODO"},
})
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>FzfLua files<CR>", { noremap = true, silent = true })
