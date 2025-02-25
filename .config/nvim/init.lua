require("plugins")
require("keymapping")
require("nvimtree")
require("config.whichKey")
require("config.terminal")
require("config.harpoon")
require("config.nvim_cmp")
require("config.debugger")
require("config.TODOComments")
require("config.auto_cmp")
require("config.luaSnip")
require("config.ufo")
require("colorizer")
require("config.git_signs")
require("colorscheme")
require("Telescope")
require("config.neogencon")
require("config.lualine")
require("config.tree-sitter")
require("config.toggleterm")
require("options")
require("config.java_scripts")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.slint",
    command = "set filetype=slint",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.jte",
    callback = function()
        vim.bo.filetype = "jte"
        local ext = vim.fn.expand("%:e")
        if ext == "jte" then
            vim.cmd("set syntax=html")
        end
    end,
})
