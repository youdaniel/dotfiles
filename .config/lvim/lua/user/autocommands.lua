local M = {}

M.config = function()
  lvim.autocommands.custom_groups = {
    { "BufNewFile", "*.cpp", "0r ~/Documents/CP/cp.cpp | $d" },
    {
      "FileType",
      "cpp",
      "nnoremap <F9> :w <bar> !g++ -std=c++17 -Wshadow -Wall % -o %:r -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG <CR>",
    },
    { "FileType", "markdown", "set nowrap" },
    { "FileType", "alpha", "nnoremap <silent> <buffer> q :q<CR>" },
    {
      "FileType",
      "alpha",
      "set laststatus=0 | set noruler | autocmd BufLeave <buffer> set laststatus=2",
    },
  }
end

return M
