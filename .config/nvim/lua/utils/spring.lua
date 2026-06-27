local M = {}

local function setup_highlights()
  local hls = {
    SpringMethodGET = { fg = "#98C379", bold = true },
    SpringMethodPOST = { fg = "#61AFEF", bold = true },
    SpringMethodPUT = { fg = "#E5C07B", bold = true },
    SpringMethodDELETE = { fg = "#E06C75", bold = true },
    SpringMethodALL = { fg = "#C678DD", bold = true },
    SpringPropKey = { fg = "#E5C07B", bold = true },    -- Yellow-ish for keys
    SpringBeanInjected = { fg = "#61AFEF", bold = true }, -- Blue for beans
  }
  for hl_name, spec in pairs(hls) do
    vim.api.nvim_set_hl(0, hl_name, spec)
  end
end

-- Helper to safely handle file jump actions
local function navigate_to_selection(prompt_bufnr)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)

  if selection and selection.path then
    vim.cmd("edit " .. vim.fn.fnameescape(selection.path))
    pcall(vim.api.nvim_win_set_cursor, 0, { selection.lnum, selection.col - 1 })
  end
end

--- ==========================================
--- FEATURE 1: Configuration Property Finder (IntelliJ "Go to Property")
--- ==========================================
function M.find_config_properties()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local entry_display = require("telescope.pickers.entry_display")

  setup_highlights()

  local displayer = entry_display.create({
    separator = "  ",
    items = {
      { width = 40 },    -- Property Key
      { width = 30 },    -- Current Value assigned
      { remaining = true }, -- File target (application.properties etc)
    },
  })

  -- Matches lines that aren't comments and contain a key-value assignment (= or :)
  local cmd = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "-g",
    "*.properties",
    "-g",
    "*.yml",
    "-g",
    "*.yaml",
    "-e",
    "^[^#%s]+%s*[=:]",
    vim.fn.getcwd(),
  }

  pickers
      .new({}, {
        prompt_title = "Spring Configuration Properties",
        finder = finders.new_oneshot_job(cmd, {
          entry_maker = function(line)
            local filename, lnum, col, text = string.match(line, "([^:]+):(%d+):(%d+):(.*)")
            if not filename then
              return nil
            end

            -- Clean up text and separate key from value
            text = vim.trim(text)
            local key, val = string.match(text, "^([^=:]+)%s*[=:]%s*(.*)$")
            if not key then
              return nil
            end

            key = vim.trim(key)
            val = vim.trim(val)
            local file_lbl = vim.fn.fnamemodify(filename, ":t")

            return {
              value = filename,
              ordinal = key .. " " .. val .. " " .. file_lbl,
              path = filename,
              lnum = tonumber(lnum),
              col = tonumber(col),
              display = function(entry)
                return displayer({
                  { entry.key, "SpringPropKey" },
                  { entry.val == "" and "(empty)" or entry.val, "Comment" },
                  { "󱁯 " .. entry.file_lbl, "Normal" },
                })
              end,
              key = key,
              val = val,
              file_lbl = file_lbl,
            }
          end,
        }),
        previewer = conf.grep_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          local actions = require("telescope.actions")
          actions.select_default:replace(function()
            navigate_to_selection(prompt_bufnr)
          end)
          return true
        end,
      })
      :find()
end

--- ==========================================
--- FEATURE 2: Bean Dependency & Usage Lookup
--- ==========================================
function M.find_bean_dependencies()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local entry_display = require("telescope.pickers.entry_display")

  setup_highlights()

  -- Grab the class name under your cursor
  local current_bean = vim.fn.expand("<cword>")
  if current_bean == "" then
    vim.notify("Place cursor on a Class/Bean name first", vim.log.levels.WARN)
    return
  end

  local displayer = entry_display.create({
    separator = "  ",
    items = {
      { width = 12 },    -- Context/Usage Type
      { width = 35 },    -- Code context snippet
      { remaining = true }, -- Target Class File
    },
  })

  -- Find where this bean is referenced as a type parameter or declaration
  local cmd = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "-g",
    "*.java",
    "-e",
    string.format("\\b%s\\b", current_bean),
    vim.fn.getcwd(),
  }

  pickers
      .new({}, {
        prompt_title = string.format("Injections & Usages of: %s", current_bean),
        finder = finders.new_oneshot_job(cmd, {
          entry_maker = function(line)
            local filename, lnum, col, text = string.match(line, "([^:]+):(%d+):(%d+):(.*)")
            if not filename then
              return nil
            end

            text = vim.trim(text)
            -- Skip self definitions or imports to focus cleanly on consumer targets
            if text:match("^import ") or text:match("^package ") then
              return nil
            end

            local context_type = "USAGE"
            if text:match("private final") or text:match("@Autowired") then
              context_type = "INJECTED FIELD"
            elseif text:match("public%s+%w+%s*(") then
              context_type = "CONSTRUCTOR"
            elseif text:match("@Bean") then
              context_type = "BEAN FACTORY"
            end

            local target_class = vim.fn.fnamemodify(filename, ":t:r")

            return {
              value = filename,
              ordinal = context_type .. " " .. text .. " " .. target_class,
              path = filename,
              lnum = tonumber(lnum),
              col = tonumber(col),
              display = function(entry)
                return displayer({
                  { entry.context_type, "SpringBeanInjected" },
                  { entry.text, "Normal" },
                  { "󱄅 " .. entry.target_class, "Comment" },
                })
              end,
              context_type = context_type,
              text = text,
              target_class = target_class,
            }
          end,
        }),
        previewer = conf.grep_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          local actions = require("telescope.actions")
          actions.select_default:replace(function()
            navigate_to_selection(prompt_bufnr)
          end)
          return true
        end,
      })
      :find()
end

--- ==========================================
--- EXISTING FEATURE: Endpoints Tracker
--- ==========================================
function M.find_springboot_endpoints()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local entry_display = require("telescope.pickers.entry_display")

  setup_highlights()

  local displayer = entry_display.create({
    separator = "  ",
    items = {
      { width = 6 },
      { width = 45 },
      { remaining = true },
    },
  })

  local search_regex =
  [=[@(GetMapping|PostMapping|PutMapping|DeleteMapping|RequestMapping)\s*\(\s*(value\s*=\s*)?"[^"]+"]=]

  local cmd = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--pcre2",
    "-e",
    search_regex,
    vim.fn.getcwd(),
  }

  pickers
      .new({}, {
        prompt_title = "Spring Boot Endpoints",
        finder = finders.new_oneshot_job(cmd, {
          entry_maker = function(line)
            local filename, lnum, col, text = string.match(line, "([^:]+):(%d+):(%d+):(.*)")
            if not filename then
              return nil
            end

            local method_type, annotation_args = string.match(text, "@(%w+Mapping)%s*%((.*)%)")
            if not method_type then
              return nil
            end

            local method_map = {
              GetMapping = "GET",
              PostMapping = "POST",
              PutMapping = "PUT",
              DeleteMapping = "DELETE",
              RequestMapping = "ALL",
            }
            local method = method_map[method_type] or "REQ"

            local path = string.match(annotation_args, '"([^"]+)"')
                or string.match(annotation_args, "'([^']+)'")
                or "/"
            local controller = vim.fn.fnamemodify(filename, ":t:r")

            return {
              value = filename,
              ordinal = method .. " " .. path .. " " .. controller,
              path = filename,
              lnum = tonumber(lnum),
              col = tonumber(col),
              display = function(entry)
                return displayer({
                  { entry.method, "SpringMethod" .. entry.method },
                  { entry.path_uri, "Normal" },
                  { "󱄅 " .. entry.controller, "Comment" },
                })
              end,
              method = method,
              path_uri = path,
              controller = controller,
            }
          end,
        }),
        previewer = conf.grep_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          local actions = require("telescope.actions")
          actions.select_default:replace(function()
            navigate_to_selection(prompt_bufnr)
          end)
          return true
        end,
      })
      :find()
end

return M
