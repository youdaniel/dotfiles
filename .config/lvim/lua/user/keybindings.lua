local M = {}

M.config = function()
  lvim.keys.visual_mode["<C-c>"] = '"+yi'
  lvim.keys.visual_mode["<C-v>"] = 'c<ESC>"+p'
  lvim.keys.insert_mode["<C-v>"] = '<ESC>"+pa'

  if lvim.builtin.fancy_bufferline.active then
    lvim.keys.normal_mode["<S-x>"] = ":bdelete!<CR>"
    lvim.keys.normal_mode["<S-l>"] = "<Cmd>BufferLineCycleNext<CR>"
    lvim.keys.normal_mode["<S-h>"] = "<Cmd>BufferLineCyclePrev<CR>"
    lvim.keys.normal_mode["[b"] = "<Cmd>BufferLineMoveNext<CR>"
    lvim.keys.normal_mode["]b"] = "<Cmd>BufferLineMovePrev<CR>"
    lvim.builtin.which_key.mappings["c"] = { "<CMD>bdelete!<CR>", "Close Buffer" }
  end

  lvim.builtin.which_key.mappings["n"] = {
    name = "Neogen",
    c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
    f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
    t = { "<cmd>lua require('neogen').generate({ type = 'type'})<CR>", "Type Documentation" },
  }
end

return M
