return {
  "akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",
  keys = { { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" } },
  opts = {
    open_mapping = "<C-\\>",
    direction = "float",
    float_opts = { border = "curved" },
    shade_filetypes = {},
    hide_numbers = true,
    insert_mappings = true,
    start_in_insert = true,
    close_on_exit = true,
  },
}
