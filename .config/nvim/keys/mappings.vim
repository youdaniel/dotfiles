" Source config
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Better window navigation
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Copy and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" cp stuff
map <leader>c :%y+<CR>
autocmd BufNewFile *.cpp 0r ~/MEGA/CP/cp.cpp 
autocmd FileType cpp setlocal commentstring=//\ %s
autocmd FileType cpp nnoremap <F8> :w <bar> !g++ -std=c++17 -Wshadow -Wall % -o %:r -O2 -Wno-unused-result <CR>
autocmd FileType cpp nnoremap <F9> :w <bar> !g++ -std=c++17 -Wshadow -Wall % -o %:r -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG <CR>

" Undotree
nnoremap <leader>u :UndotreeShow<CR>
