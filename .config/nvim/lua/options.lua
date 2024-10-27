-- HINT: USE `:H <OPTION>` TO FIGURE OUT THE MEANING IF NEEDED
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
-- Tab
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spacesin tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered
vim.o.pumheight = 15
vim.opt.guicursor = "i:block"

vim.opt.wrap = false
-- vim.opt.smartindent = true
vim.opt.scrolloff = 8
-- vim.opt.updatetime = 50

vim.opt.fillchars = { fold = " " }
vim.opt.foldmethod = "expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 20
vim.g.markdown_folding = 1
vim.g.markdown_enable_folding = 1

-- 0.10 neovim
vim.opt.smoothscroll = true
