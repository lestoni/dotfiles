" .vimrc

" Author: Tony Mutai <tonimut7@gmail.com>
" Raw version: http://raw.github.com/lestoni/dotfiles/master/.vimrc
"

" !silent is used to suppress error messages if the config line
" references plugins/colorschemes that might be missing

" >>>>>>>>>>>>>>>>>
"  Settings.
" <<<<<<<<<<<<<<<<

" Make Vim more useful
set nocompatible

" quantity of lines vim have to remember
set history=500

" Centralize backups, swapfiles and undo history
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/swaps
if exists("&undodir")
    set undodir=$HOME/.vim/undo
endif
set viminfo+=n$HOME/.vim/.viminfo

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*

" Respect modeline in files
set modeline
set modelines=4

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" Use relative line numbers
" if exists("&relativenumber")
    " set relativenumber
    " au BufReadPost * set relativenumber
" endif


" >>>>>>>>>>>>>>>>
"  Colors and Font.
" <<<<<<<<<<<<<<<<

" Enable syntax highlighting
syntax on

" Set 256 color terminal support
set t_Co=256


" >>>>>>>>>>>>>>>
" User interface.
" <<<<<<<<<<<<<<<

" Enable line numbers
set number

" Highlight current line
" set cursorline

" No line wrapping
set nowrap

" Show “invisible” characters
" set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set lcs=tab:▸\ ,trail:·,nbsp:_
set list

" Always show status line
set laststatus=2

" Enable mouse in all modes
set mouse=a

" Disable error bells
set noerrorbells

" Don’t reset cursor to start of line when moving around.
" set nostartofline

" Show the cursor position
set ruler

" Don’t show the intro message when starting Vim
set shortmess=atI

" Show the current mode
set showmode

" Show the filename in the window titlebar
" set title

" Show the (partial) command as it’s being typed
set showcmd

" Enhance command-line completion
set wildmenu

" Allow cursor keys in insert mode
set esckeys

" Allow backspace in insert mode
set backspace=indent,eol,start

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Behavior & Different Tricks.
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Optimize for fast terminal connections
set ttyfast

" Add the g flag to search/replace by default
set gdefault

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" Ignore case in search
set smartcase

" A buffer is marked as ‘hidden’ if it has unsaved changes, and it is not currently loaded in a window
" if you try and quit Vim while there are hidden buffers, you will raise an error:
" E162: No write since last change for buffer “a.txt”
set hidden

" Autoload files that have changed outside of vim
set autoread

" Always highlight column 80 so it's easier to see where
" cutoff appears on longer screens
autocmd BufWinEnter * highlight ColorColumn ctermbg=darkred
set colorcolumn=80


" >>>>>>>>>>>>>>
" Indentations.
" <<<<<<<<<<<<<

" Use soft tab - 2 spaces
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab


" >>>>>>>>>>>>>>>>>>>
" Hotkeys & Bindings.
" <<<<<<<<<<<<<<<<<<

" Change mapleader
let mapleader=","

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Close all folds when opening a new buffer
autocmd BufRead * setlocal foldmethod=indent
autocmd BufRead * normal zM

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Filetype Dependent Settings.
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    filetype indent on
    filetype plugin on

    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

    " Automatically strip trailing whitespace on file save
    autocmd BufWritePre *.css,*.html,*.js,*.json,*.md,*.r,*.py,*.scss,*.sh,*.txt,*.less :call StripWhitespace()

    " For all text files set 'textwidth' to 80 characters.
    autocmd FileType text setlocal textwidth=80

    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4

    " Setup html template
    " autocmd BufNewFile *.html 0r ~/tmp.html
endif

" Don’t add empty newlines at the end of files
" set binary
" set noeol

" >>>>>>>>>>>
" Plugins.
" <<<<<<<<<<<<

" Call pathogen plugin management
execute pathogen#infect()

" Automatically generate help files for any plugin installed.
execute pathogen#helptags()

" required by Pathogen Plugin Manager
" filetype plugin indent on

" Set theme
set background=dark
colorscheme molokai

"=> Airline (status line)
let g:airline_powerline_fonts = 1

"=> livedown(markdown live preview)
let g:livedown_open = 0

" Markdown turn off folding
let g:vim_markdown_folding_disabled=1
