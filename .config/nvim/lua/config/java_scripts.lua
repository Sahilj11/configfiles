function RunMavenTestClass()
	-- Check if the filetype is Java
	if vim.bo.filetype ~= "java" then
		print("The current file is not a Java file.")
		return
	end

	local buf = vim.api.nvim_get_current_buf()
	local file_path = vim.api.nvim_buf_get_name(buf)

	-- Get and modify the first line
	local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
	local space_pos = first_line:find("%s")
	if space_pos then
		first_line = first_line:sub(space_pos + 1)
	end
	if first_line:sub(-1) == ";" then
		first_line = first_line:sub(1, -2)
	end

	-- Get the file name without extension
	local file_name = vim.fn.fnamemodify(file_path, ":t")
	local name_without_ext = vim.fn.fnamemodify(file_name, ":r")

	-- Combine results with a dot
	local combined_result = first_line .. "." .. name_without_ext

	-- Create the Maven command
	local command = string.format("mvn -Dtest=%s test", combined_result)

	-- Copy the command to the system clipboard using xclip
	os.execute("echo '" .. command .. "' | xclip -selection clipboard")

	print("Command copied to clipboard: " .. command)
end

function GetWordUnderCursor()
    -- Get the cursor position (line, column) in the current buffer
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local line = cursor_pos[1] - 1  -- Convert to zero-based index
    local col = cursor_pos[2]

    -- Get the line content
    local line_content = vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1]

    -- Find the start and end of the word under the cursor
    local start_col = line_content:find("%w+", col)
    if not start_col then
        print("No word found under cursor.")
        return
    end

    local end_col = line_content:find("%W", start_col) or (#line_content + 1)

    -- Extract the word
    local word = line_content:sub(start_col, end_col - 1)

    return word
end

function RunMavenTestMethod()
    -- Get the word under the cursor
    local cursor_word = GetWordUnderCursor()
    if not cursor_word then
        return
    end

    -- Check if the filetype is Java
    if vim.bo.filetype ~= "java" then
        print("The current file is not a Java file.")
        return
    end

    local buf = vim.api.nvim_get_current_buf()
    local file_path = vim.api.nvim_buf_get_name(buf)

    -- Get and modify the first line
    local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
    local space_pos = first_line:find("%s")
    if space_pos then
        first_line = first_line:sub(space_pos + 1)
    end
    if first_line:sub(-1) == ";" then
        first_line = first_line:sub(1, -2)
    end

    -- Get the file name without extension
    local file_name = vim.fn.fnamemodify(file_path, ":t")
    local name_without_ext = vim.fn.fnamemodify(file_name, ":r")

    -- Combine results with a #
    local combined_result = first_line ..".".. name_without_ext.."#"..cursor_word

    -- Create the Maven command
    local command = string.format("mvn -Dtest=%s test", combined_result)

    -- Copy the command to the system clipboard using xclip (for Linux) or pbcopy (for macOS)
    os.execute("echo '" .. command .. "' | xclip -selection clipboard")

    print("Maven command generated: " .. command)
end
