let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS = "--reverse --inline-info"

command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, {'options': ['--preview', 'bat --color=always --style=plain {}', '--preview-window', 'right:60%']}, <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --glob "!{node_modules,.git}" --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

nnoremap <C-p> :Files<CR>
nnoremap <leader>ps :Rg<CR>
