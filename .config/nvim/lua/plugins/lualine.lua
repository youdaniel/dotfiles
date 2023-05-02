local icons = require("lazyvim.config").icons

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
  local _time = os.date("*t")
  local selector = math.floor(_time.hour / 8) + 1
  local normal_icons = {
    " 󰊠 ",
    "  ",
    "  ",
  }
  if mod == "n" or mod == "no" or mod == "nov" then
    return normal_icons[selector]
  elseif mod == "i" or mod == "ic" or mod == "ix" then
    local insert_icons = {
      " 󰏒 ",
      "  ",
      "  ",
    }
    return insert_icons[selector]
  elseif mod == "V" or mod == "v" or mod == "vs" or mod == "Vs" or mod == "cv" then
    local verbose_icons = {
      " 󰕷",
      "  ",
      "  ",
    }
    return verbose_icons[selector]
  elseif mod == "c" or mod == "ce" then
    local command_icons = {
      " 󰱫 ",
      "  ",
      "  ",
    }

    return command_icons[selector]
  elseif mod == "r" or mod == "rm" or mod == "r?" or mod == "R" or mod == "Rc" or mod == "Rv" or mod == "Rv" then
    local replace_icons = {
      " 󰉼 ",
      "  ",
      "  ",
    }
    return replace_icons[selector]
  end
  return normal_icons[selector]
end

local colors = {
  rosewater = "#F5E0DC",
  flamingo = "#F2CDCD",
  violet = "#DDB6F2",
  pink = "#F5C2E7",
  red = "#F28FAD",
  maroon = "#E8A2AF",
  orange = "#F8BD96",
  yellow = "#FAE3B0",
  green = "#ABE9B3",
  blue = "#96CDFB",
  cyan = "#89DCEB",
  teal = "#B5E8E0",
  lavender = "#C9CBFF",
  white = "#D9E0EE",
  gray2 = "#C3BAC6",
  gray1 = "#988BA2",
  gray0 = "#6E6C7E",
  black4 = "#575268",
  bg_br = "#302D41",
  bg = "#1A1826",
  bg_alt = "#1E1E2E",
  fg = "#D9E0EE",
  black = "#1A1826",
  git = {
    add = "#ABE9B3",
    change = "#96CDFB",
    delete = "#F28FAD",
    conflict = "#FAE3B0",
  },
}
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
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  hide_small = function()
    return vim.fn.winwidth(0) > 150
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    component_separators = "",
    section_separators = "",
    disabled_filetypes = { statusline = { "alpha" } },
    globalstatus = true,
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

ins_left({
  function()
    return mode()
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()], bg = colors.bg }
  end,
  padding = { left = 1, right = 0 },
})

ins_left({
  "b:gitsigns_head",
  icon = " ",
  cond = conditions.check_git_workspace,
  color = { fg = colors.blue },
  padding = 0,
})

ins_left({
  function()
    local fname = vim.fn.expand("%:p")
    local ftype = vim.fn.expand("%:e")
    local cwd = vim.api.nvim_call_function("getcwd", {})
    local show_name = vim.fn.expand("%:t")
    if #cwd > 0 and #ftype > 0 then
      show_name = fname:sub(#cwd + 2)
    end
    return show_name .. "%{&readonly?' 󰏮 ':''}" .. "%{&modified?'  ':''}"
  end,
  cond = conditions.buffer_not_empty,
  padding = { left = 1, right = 1 },
  color = { fg = colors.fg, gui = "bold" },
})

ins_left({
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
})

ins_left({
  function()
    local function trim(s)
      if string.len(s) > 10 and vim.fn.winwidth(0) < 120 then
        return string.sub(s, 0, 10) .. "..."
      end
      return s
    end

    local function env_cleanup(venv)
      if string.find(venv, "/") then
        local final_venv = venv
        for w in venv:gmatch("([^/]+)") do
          final_venv = w
        end
        venv = final_venv
      end
      return venv
    end

    if vim.bo.filetype == "python" then
      local venv = os.getenv("CONDA_DEFAULT_ENV")
      if venv then
        return string.format("  (%s)", trim(env_cleanup(venv)))
      end
      venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return string.format("  (%s)", trim(env_cleanup(venv)))
      end
    end
    return ""
  end,
  color = { fg = colors.green },
  cond = conditions.hide_in_width,
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
  function()
    return "%="
  end,
})

ins_right({
  function()
    return (not vim.bo.readonly or not vim.bo.modifiable) and "" or ""
  end,
  color = { fg = colors.red },
})

ins_right({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = icons.diagnostics.Error,
    warn = icons.diagnostics.Warn,
    info = icons.diagnostics.Info,
    hint = icons.diagnostics.Hint,
  },
  cond = conditions.hide_in_width,
})

ins_right({
  function()
    return next(vim.treesitter.highlighter.active) and "  " or ""
  end,
  padding = 0,
  color = { fg = colors.green },
  cond = conditions.hide_in_width,
})

ins_right({
  function(msg)
    local function get_registered_providers(filetype)
      local s = require("null-ls.sources")
      local available_sources = s.get_available(filetype)
      local registered = {}
      for _, source in ipairs(available_sources) do
        for method in pairs(source.methods) do
          registered[method] = registered[method] or {}
          table.insert(registered[method], source.name)
        end
      end
      return registered
    end

    local function add_clients(dest, src, has_name)
      for _, client in pairs(src) do
        local _client = has_name and client.name or client
        if _client ~= "null-ls" then
          if not conditions.hide_in_width() then
            _client = string.sub(client.name, 1, 4)
          end
          table.insert(dest, _client)
        end
      end
    end

    msg = msg or "󰒎 LS Inactive"
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    if next(clients) == nil then
      return (type(msg) == "boolean" or #msg == 0) and "󰒎 LS Inactive" or msg
    end

    local client_names = {}
    local null_ls = require("null-ls")
    local providers = get_registered_providers(vim.bo.filetype)
    add_clients(client_names, clients, true)
    add_clients(client_names, providers[null_ls.methods.FORMATTING] or {}, false)
    add_clients(client_names, providers[null_ls.methods.DIAGNOSTICS] or {}, false)

    return "󰒍 " .. table.concat(client_names, ", ")
  end,
  color = { fg = colors.fg },
})

ins_right({
  "location",
  padding = 0,
  color = { fg = colors.orange },
})

ins_right({
  "filesize",
  cond = conditions.buffer_not_empty,
})

ins_right({
  function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end,
  padding = 0,
  color = { fg = colors.yellow, bg = colors.bg },
  cond = nil,
})

return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    return config
  end,
}
