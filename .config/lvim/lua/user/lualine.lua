local M = {}
local kind = require "user.lsp_kind"

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local mode = function()
  local mod = vim.fn.mode()
  local _time = os.date "*t"
  local selector = math.floor(_time.hour / 8) + 1
  local normal_icons = {
    "  ",
    "  ",
    "  ",
  }
  if mod == "n" or mod == "no" or mod == "nov" then
    return normal_icons[selector]
  elseif mod == "i" or mod == "ic" or mod == "ix" then
    local insert_icons = {
      "  ",
      "  ",
      "  ",
    }
    return insert_icons[selector]
  elseif mod == "V" or mod == "v" or mod == "vs" or mod == "Vs" or mod == "cv" then
    local verbose_icons = {
      " 勇",
      "  ",
      "  ",
    }
    return verbose_icons[selector]
  elseif mod == "c" or mod == "ce" then
    local command_icons = {
      "  ",
      "  ",
      "  ",
    }

    return command_icons[selector]
  elseif mod == "r" or mod == "rm" or mod == "r?" or mod == "R" or mod == "Rc" or mod == "Rv" or mod == "Rv" then
    local replace_icons = {
      "  ",
      "  ",
      "  ",
    }
    return replace_icons[selector]
  end
  return normal_icons[selector]
end

local default_colors = {
  bg = "#44475A",
  fg = "#F8F8F2",
  yellow = "#F1FA8C",
  cyan = "#8BE9FD",
  green = "#50FA7B",
  orange = "#FFB86C",
  violet = "#BD93F9",
  pink = "#FF79C6",
  blue = "#8BE9FD",
  red = "#FF5555",
  git = { change = "#FFB86C", add = "#50FA7B", delete = "#FF5555" },
}
M.config = function()
  local colors = default_colors

  -- Color table for highlights
  local mode_color = {
    n = colors.git.delete,
    i = colors.green,
    v = colors.yellow,
    [""] = colors.blue,
    V = colors.yellow,
    c = colors.cyan,
    no = colors.magenta,
    s = colors.orange,
    S = colors.orange,
    [""] = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ["r?"] = colors.cyan,
    ["!"] = colors.red,
    t = colors.red,
  }
  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    hide_small = function()
      return vim.fn.winwidth(0) > 150
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand "%:p:h"
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  -- Config
  local config = {
    options = {
      icons_enabled = true,
      -- Disable sections and component separators
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      theme = {
        -- We are going to use lualine_c an lualine_x as left and
        -- right section. Both are highlighted by c theme .  So we
        -- are just setting default looks o statusline
        normal = { c = { fg = colors.fg, bg = colors.bg } },
        inactive = { c = { fg = colors.fg, bg = colors.bg_alt } },
      },
      disabled_filetypes = { "dashboard", "NvimTree", "Outline", "alpha" },
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},

      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      -- These will be filled later
      lualine_c = {},
      lualine_x = {},
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_v = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }

  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x ot right section
  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  ins_left {
    function()
      vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
      return mode()
    end,
    color = "LualineMode",
    padding = { left = 1, right = 0 },
  }

  ins_left {
    "b:gitsigns_head",
    icon = " ",
    cond = conditions.check_git_workspace,
    color = { fg = colors.blue },
    padding = 0,
  }

  ins_left {
    function()
      local fname = vim.fn.expand "%:p"
      local ftype = vim.fn.expand "%:e"
      local cwd = vim.api.nvim_call_function("getcwd", {})
      local show_name = vim.fn.expand "%:t"
      if #cwd > 0 and #ftype > 0 then
        show_name = fname:sub(#cwd + 2)
      end
      return show_name .. "%{&readonly?'  ':''}" .. "%{&modified?'  ':''}"
    end,
    cond = conditions.buffer_not_empty,
    padding = { left = 1, right = 1 },
    color = { fg = colors.fg, gui = "bold" },
  }

  ins_left {
    "diff",
    source = diff_source,
    symbols = { added = "  ", modified = "柳", removed = " " },
    diff_color = {
      added = { fg = colors.git.add },
      modified = { fg = colors.git.change },
      removed = { fg = colors.git.delete },
    },
    color = {},
    cond = nil,
  }

  ins_left {
    function()
      local utils = require "lvim.core.lualine.utils"
      if vim.bo.filetype == "python" then
        local venv = os.getenv "CONDA_DEFAULT_ENV"
        if venv then
          return string.format("  (%s)", utils.env_cleanup(venv))
        end
        venv = os.getenv "VIRTUAL_ENV"
        if venv then
          return string.format("  (%s)", utils.env_cleanup(venv))
        end
        return ""
      end
      return ""
    end,
    color = { fg = colors.green },
    cond = conditions.hide_in_width,
  }

  -- Insert mid section. You can make any number of sections in neovim :)
  -- for lualine it's any number greater then 2
  ins_left {
    function()
      return "%="
    end,
  }

  ins_right {
    function()
      if not vim.bo.readonly or not vim.bo.modifiable then
        return ""
      end
      return "" -- """
    end,
    color = { fg = colors.red },
  }

  ins_right {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = kind.icons.error, warn = kind.icons.warn, info = kind.icons.info, hint = kind.icons.hint },
    cond = conditions.hide_in_width,
  }

  ins_right {
    function()
      if next(vim.treesitter.highlighter.active) then
        return "  "
      end
      return ""
    end,
    padding = 0,
    color = { fg = colors.green },
    cond = conditions.hide_in_width,
  }

  ins_right {
    function(msg)
      msg = msg or kind.icons.ls_inactive .. "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
          return kind.icons.ls_inactive .. "LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}
      local trim = vim.fn.winwidth(0) < 120

      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          local _added_client = client.name
          if trim then
            _added_client = string.sub(client.name, 1, 4)
          end
          table.insert(buf_client_names, _added_client)
        end
      end

      -- add formatter
      local formatters = require "lvim.lsp.null-ls.formatters"
      local supported_formatters = {}
      for _, fmt in pairs(formatters.list_registered(buf_ft)) do
        local _added_formatter = fmt
        if trim then
          _added_formatter = string.sub(fmt, 1, 4)
        end
        table.insert(supported_formatters, _added_formatter)
      end
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require "lvim.lsp.null-ls.linters"
      local supported_linters = {}
      for _, lnt in pairs(linters.list_registered(buf_ft)) do
        local _added_linter = lnt
        if trim then
          _added_linter = string.sub(lnt, 1, 4)
        end
        table.insert(supported_linters, _added_linter)
      end
      vim.list_extend(buf_client_names, supported_linters)

      return kind.icons.ls_active .. table.concat(buf_client_names, ", ")
    end,
    color = { fg = colors.fg },
    -- cond = conditions.hide_in_width,
  }

  ins_right {
    "location",
    padding = 0,
    color = { fg = colors.orange },
  }

  ins_right {
    function()
      local function format_file_size(file)
        local size = vim.fn.getfsize(file)
        if size <= 0 then
          return ""
        end
        local sufixes = { "b", "k", "m", "g" }
        local i = 1
        while size > 1024 do
          size = size / 1024
          i = i + 1
        end
        return string.format("%.1f%s", size, sufixes[i])
      end
      local file = vim.fn.expand "%:p"
      if string.len(file) == 0 then
        return ""
      end
      return format_file_size(file)
    end,
    cond = conditions.buffer_not_empty,
  }

  ins_right {
    function()
      local current_line = vim.fn.line "."
      local total_lines = vim.fn.line "$"
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = 0,
    color = { fg = colors.yellow, bg = colors.bg },
    cond = nil,
  }

  -- Now don't forget to initialize lualine
  lvim.builtin.lualine.options = config.options
  lvim.builtin.lualine.sections = config.sections
  lvim.builtin.lualine.inactive_sections = config.inactive_sections
end

return M
