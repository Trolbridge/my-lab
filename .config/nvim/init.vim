
set nocompatible              " be iMproved, required
filetype on                  " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
" filetype indent on "maintain indentation


call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'neoclide/coc.nvim', { 'branch': 'release'}
Plug 'gruvbox-community/gruvbox' "Test
" "Plug 'mattn/emmet-vim' "For HTML
" "Plug 'Yggdroot/indentLine'
" "Plug 'dense-analysis/ale'
" "Plug 'StanAngeloff/php.vim'
call plug#end()

colorscheme gruvbox
" highlight Normal guibg=none

"===================================
"       Indention Options
"===================================
set autoindent
set smartindent
set tabstop=4 softtabstop=4
set expandtab
set smarttab
set shiftround
set shiftwidth=4

"===================================
"         Search Options
"===================================
set nohlsearch
set hidden
set ignorecase
set incsearch
set smartcase

"===================================
"       Performance Options
"===================================
set lazyredraw "Dont update screen during macro and script execution

"===================================
"      Text Rendering Options
"===================================
set display+=lastline
set ruler
set encoding=utf-8
set linebreak
set scrolloff=20
set sidescrolloff=5
syntax on
set nowrap
set colorcolumn=80

"===================================
"      User Interface Options
"===================================
set laststatus=2
set wildmenu
set tabpagemax=50
set cursorline
set nu
set relativenumber
set noerrorbells
set visualbell
set mouse=a
set title
"set background=dark
set t_Co=256 "required for urxvt

"===================================
"      Miscellaneous Options
"===================================
set backspace=indent,eol,start
set backupdir=~/.config/nvim/backup
set dir=~/.config/nvim/swap
set undodir=~/.config/nvim/undo
set undofile
set formatoptions+=j    " Delete comment characters when joining lines.
set history=1000
"set shell               " The shell used to execute commands.
set wildignore+=.pyc,.swp " Ignore files matching these patterns when
" opening files based on a glob pattern.
set autowriteall
" Set Modifiable
set ma

"===================================
"           Remaps Area
"===================================
" inoremap <Leader> " " "<======== TODO work on this
imap ;; <ESC>
imap <F4> <ESC> :GoRun %<Return>
noremap <F4> :GoRun %<Return>
noremap <F5> yy:!<C-r>"<BS><Return>

let g:indentLine_setColors = 0
let g:indentLine_color_term = 239

"/dev/null 2>&1 ; then git add % ; git commit -m "Auto-commit: saved %"; fi >
"/dev/null 2>&1'
