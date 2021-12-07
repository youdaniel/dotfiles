local M = {}

M.config = function()
  local icons = require("user.lsp_kind").icons
  local function is_ft(b, ft)
    return vim.bo[b].filetype == ft
  end

  local symbols = { error = icons.error, warning = icons.warn, info = icons.info }

  local function diagnostics_indicator(_, _, diagnostics)
    local result = {}
    for name, count in pairs(diagnostics) do
      if symbols[name] and count > 0 then
        table.insert(result, symbols[name] .. count)
      end
    end
    result = table.concat(result, " ")
    return #result > 0 and result or ""
  end

  local function custom_filter(buf, buf_nums)
    local logs = vim.tbl_filter(function(b)
      return is_ft(b, "log")
    end, buf_nums)
    if vim.tbl_isempty(logs) then
      return true
    end
    local tab_num = vim.fn.tabpagenr()
    local last_tab = vim.fn.tabpagenr "$"
    local is_log = is_ft(buf, "log")
    if last_tab == 1 then
      return true
    end
    -- only show log buffers in secondary tabs
    return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
  end

  require("bufferline").setup { ---@diagnostic disable-line
    options = {
      sort_by = "id",
      right_mouse_command = "vert sbuffer %d",
      show_close_icon = false,
      show_buffer_icons = true,
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = false,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = diagnostics_indicator,
      diagnostics_update_in_insert = false,
      custom_filter = custom_filter,
      offsets = {
        {
          filetype = "NvimTree",
          text = "Explorer",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "packer",
          text = "Packer",
          highlight = "PanelHeading",
          padding = 1,
        },
      },
    },
  }
end

return M
