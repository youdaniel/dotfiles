local M = {}

M.config = function()
  lvim.keys.visual_mode["<C-c>"] = '"+yi'
  lvim.keys.visual_mode["<C-v>"] = 'c<ESC>"+p'
  lvim.keys.insert_mode["<C-v>"] = '<ESC>"+pa'

  lvim.builtin.which_key.mappings["n"] = {
    name = "Neogen",
    c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
    f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
    t = { "<cmd>lua require('neogen').generate({ type = 'type'})<CR>", "Type Documentation" },
  }

  lvim.builtin.which_key.mappings.y = { "<cmd>%y+<CR>", "Copy All" }
  lvim.builtin.which_key.mappings["r"] = {
    name = "Replace",
    r = { "<cmd>lua require('spectre').open()<cr>", "Project" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Current Buffer" },
  }
end

return M
