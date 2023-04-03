-- cp
vim.api.nvim_create_user_command("CPTemplate", "0r ~/Documents/CP/cp.cpp | $d", {})
local command = {
  "<cmd>",
  ":w <bar>",
  "!g++",
  "-std=c++20",
  "-Wall",
  "-Wextra",
  "-Wshadow",
  "-ggdb3",
  "-fmax-errors=2",
  "-fsanitize=address,undefined",
  "-D_GLIBCXX_DEBUG",
  "-DLOCAL",
  "% -o %:r",
  "<cr>",
}
vim.keymap.set("n", "<F9>", table.concat(command, " "), { noremap = true })
