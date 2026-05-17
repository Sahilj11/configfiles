return {
  "nvim-treesitter/nvim-treesitter",
  -- Removing lazy = false or setting it to true allows lazy.nvim to properly 
  -- sequence the loading order so 'nvim-treesitter.configs' can actually be found.
  lazy = false, 
  build = ":TSUpdate",
  config = function()
    -- Safe require: wrapping it ensures that even if something is sequence-broken,
    -- it won't hard-crash your entire Neovim configuration on startup.
    local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    treesitter_configs.setup({
      -- A list of parser names, or "all"
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "java",
        "json",
        "javascript",
        "python",
        "css",
        "typescript",
        "svelte", -- Added svelte here so it automatically installs
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
