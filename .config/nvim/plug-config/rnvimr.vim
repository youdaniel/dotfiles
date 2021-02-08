" Make Ranger replace netrw and be the file explorer
" let g:rnvimr_enable_ex = 1

" Hide Ranger after picking file.
let g:rnvimr_enable_picker = 1

" Customize the initial layout
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': float2nr(round(0.8 * &columns)),
            \ 'height': float2nr(round(0.8 * &lines)),
            \ 'col': float2nr(round(0.1 * &columns)),
            \ 'row': float2nr(round(0.1 * &lines)),
            \ 'style': 'minimal' }

nmap <leader>r :RnvimrToggle<CR>
