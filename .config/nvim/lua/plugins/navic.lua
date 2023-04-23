return {
  "SmiteshP/nvim-navic",
  config = function()
    -- taken from LunarVim's breadcrumbs.lua
    local utils = require("utils")

    local function get_filename()
      local filename = vim.fn.expand("%:t")
      local extension = vim.fn.expand("%:e")

      if not utils.isempty(filename) then
        local file_icon, hl_group = "", "Normal"
        local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
        if devicons_ok then
          file_icon, hl_group = devicons.get_icon(filename, extension, { default = true })
        end

        return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
      end
    end

    local function get_loc()
      local navic_ok, navic = pcall(require, "nvim-navic")
      if not navic_ok then
        return ""
      end

      local loc_ok, loc = pcall(navic.get_location, {})
      if not loc_ok then
        return ""
      end

      if not utils.isempty(loc) then
        return "%#NavicSeparator#" .. ">" .. "%* " .. loc
      else
        return ""
      end
    end

    local function get_winbar()
      local exclude = {
        "help",
        "dashboard",
        "lazy",
        "neo-tree",
        "Trouble",
        "alpha",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "notify",
        "noice",
        "",
      }

      if vim.tbl_contains(exclude, vim.bo.filetype) then
        return
      end

      local value = get_filename()
      if not utils.isempty(value) then
        value = value .. " " .. get_loc()
      end

      local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
      if not status_ok then
        return
      end
    end

    vim.api.nvim_set_hl(0, "Winbar", { fg = vim.api.nvim_get_hl(0, { name = "Normal" }).foreground })
    vim.api.nvim_create_augroup("_winbar", {})
    vim.api.nvim_create_autocmd({
      "CursorHoldI",
      "CursorHold",
      "BufWinEnter",
      "BufFilePost",
      "InsertEnter",
      "BufWritePost",
      "TabClosed",
      "TabEnter",
    }, { group = "_winbar", callback = get_winbar })
  end,
}
