" https://github.com/sheerun/vim-polyglot/issues/292
let g:polyglot_disabled = ["coffee-script"]

call plug#begin('~/.config/nvim/plugged')

    " General improvements
    Plug 'tomtom/tcomment_vim'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'wellle/targets.vim'
    Plug 'Krasjet/auto.pairs'

    " Tags
    Plug 'AndrewRadev/tagalong.vim'
    Plug 'andymass/vim-matchup'
    Plug 'alvan/vim-closetag'

    " Snippets
    Plug 'honza/vim-snippets'
    Plug 'mattn/emmet-vim'

    " Intellsense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    
    " Undo stuff
    Plug 'mbbill/undotree'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'stsewd/fzf-checkout.vim'

    " Ranger
    Plug 'kevinhwang91/rnvimr'

    " Visual
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'itchyny/lightline.vim'
    Plug 'mhinz/vim-startify'

    " Language
    Plug 'sheerun/vim-polyglot'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    " VimBeGood
    Plug 'ThePrimeagen/vim-be-good'

    " Code Time
    Plug 'wakatime/vim-wakatime'

call plug#end()
