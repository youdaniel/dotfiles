local M = {}

local create_aucmd = vim.api.nvim_create_autocmd

M.config = function()
  vim.api.nvim_create_augroup("_lvim_user", {})
  create_aucmd("BufNewFile", { group = "_lvim_user", pattern = "*.cpp", command = "0r ~/Documents/CP/cp.cpp | $d" })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "cpp",
    command = "nnoremap <F9> :w <bar> !g++ -std=c++17 -Wshadow -Wall % -o %:r -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG <CR>",
  })
  create_aucmd("FileType", { group = "_lvim_user", pattern = "markdown", command = "set nowrap" })
  create_aucmd("FileType", { group = "_lvim_user", pattern = "alpha", command = "nnoremap <silent> <buffer> q :q<CR>" })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "alpha",
    command = "set laststatus=0 | set noruler | autocmd BufLeave <buffer> set laststatus=2",
  })
end

return M
