require("settings.options")
require("settings.keymaps")
require("config.lazy")
require("config.lsp")

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
