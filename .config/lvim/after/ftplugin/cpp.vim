:command CPTemplate 0r ~/Documents/CP/cp.cpp | $d
nnoremap <F9> :w <bar>
      \ !g++ -std=c++20 -Wall -Wextra -Wshadow -ggdb3 -fmax-errors=2
      \ -fsanitize=address,undefined -D_GLIBCXX_DEBUG -DLOCAL % -o %:r <CR>
