" set runtime
set runtimepath=$HOME/.dotfiles/vim/,$VIMRUNTIME

" vim-plug, plugins

" auto-install script, defaults
if empty(glob('$HOME/.dotfiles/vim/autoload/plug.vim'))
  silent !curl -fLo $HOME/.dotfiles/vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" load plugins
call plug#begin('$HOME/.dotfiles/vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-sensible'
" Plug 'joshdick/onedark.vim'
Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'sheerun/vim-polyglot'
Plug 'fxn/vim-monochrome'
Plug 'supercollider/scvim'
call plug#end()

" color scheme
syntax enable
let g:monochrome_italic_comments = 1
colorscheme monochrome

" lightline
let g:lightline = {
            \ 'colorscheme': 'nord',
            \ }
set laststatus=2
set noshowmode

" markdown
let g:vim_markdown_folding_disabled = 1

" options
set tabstop=4
set shiftwidth=4
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'
set softtabstop=4
set smarttab " insert tabs on the start of a line according to shiftwidth, not tabstop
set expandtab
" set nowrap
set wrap linebreak nolist
set switchbuf=usetab,newtab
nnoremap <F8> :tabn<CR>
nnoremap <S-F8> :tabp<CR>
set encoding=utf-8
set scrolloff=3
set autoindent
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
" set relativenumber
" set undofile
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set number " always show line numbers
set history=1000 " remember more commands and search history
let g:netrw_dirhistmax = 0
set undolevels=1000 " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
" set title " change the terminal's title
nnoremap ; :
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
let skip_defaults_vim=1
set viminfo=""
set nobackup
set noswapfile
