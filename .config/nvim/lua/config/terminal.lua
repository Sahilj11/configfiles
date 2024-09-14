local api = vim.api
api.nvim_command("autocmd TermOpen * startinsert")                        -- starts in insert mode
api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber") -- no numbers
api.nvim_command("autocmd TermEnter * setlocal signcolumn=no")

local term_open = false

function open_floating_terminal()
    local opts = {
        relative = "editor",
        width = math.floor(vim.api.nvim_get_option("columns") * 0.8),                                      -- Set width to 80% of the editor width
        height = math.floor(vim.api.nvim_get_option("lines") * 0.8),                                       -- Set height to 80% of the editor height
        row = math.floor((vim.api.nvim_get_option("lines") - (vim.api.nvim_get_option("lines") * 0.8)) / 2), -- Center vertically
        col = math.floor((vim.api.nvim_get_option("columns") - (vim.api.nvim_get_option("columns") * 0.8)) / 2), -- Center horizontally
        style = "minimal",
    }
    vim.cmd("botright vnew")
    -- vim.cmd("resize " .. opts.height)
    vim.cmd("terminal")
    vim.api.nvim_win_set_config(0, opts)
end

function open_terminal_floating()
    local opts = {
        relative = "editor",
        width = math.floor(vim.api.nvim_get_option("columns") * 0.8),
        height = math.floor(vim.api.nvim_get_option("lines") * 0.8),
        row = math.floor((vim.api.nvim_get_option("lines") - (vim.api.nvim_get_option("lines") * 0.8)) / 2),
        col = math.floor((vim.api.nvim_get_option("columns") - (vim.api.nvim_get_option("columns") * 0.8)) / 2),
        style = "minimal",
    }

    -- Iterate through each buffer
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        -- Check if the buffer is a terminal
        if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
            -- Open a floating window and set the terminal buffer in it
            local win = vim.api.nvim_open_win(buf, true, opts)
            vim.api.nvim_win_set_buf(win, buf)
            --[[ vim.api.nvim_chan_set_name(vim.api.nvim_win_get_buf(win), "term://bash") ]]
            vim.cmd("startinsert")
            return
        end
    end
    -- If no terminal buffer found, create a new one
    vim.cmd("botright vnew")
    vim.cmd("terminal")
    vim.api.nvim_win_set_config(0, opts)
end

function termCheck()
    if term_open and vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
        -- vim.cmd("resize -3")
        open_terminal_floating()
    elseif term_open == false then
        -- open_floating_terminal()
        open_terminal_floating()
        -- vim.cmd("split")
        -- vim.cmd("resize -3")
        -- vim.cmd("terminal")
        term_open = true
    elseif term_open and vim.api.nvim_buf_get_option(0, "buftype") == "terminal" then
        vim.cmd("q")
    end
end


-- function open_terminal_split()
--     -- Iterate through each buffer
--     for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--         -- Check if the buffer is a terminal
--         if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
--             -- Open a split and switch to it
--             -- vim.cmd("split")
--             open_floating_terminal()
--             vim.cmd("buffer " .. buf)
--             return
--         end
--     end
--     -- If no terminal buffer found, print a message
--     print("No terminal buffer found")
-- end
--
--
