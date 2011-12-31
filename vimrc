" good reference:
" http://mislav.uniqpath.com/2011/12/vim-revisited/
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#getting-started
" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
" http://mislav.uniqpath.com/2011/12/vim-revisited/

" installing pathogen:
" mkdir -p ~/.vim/autoload ~/.vim/bundle; \
" curl -so ~/.vim/autoload/pathogen.vim \
"     https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim

" load pathogen
call pathogen#infect()
syntax on
filetype plugin indent on " load file type plugins + indentation

" standard stuff
set nocompatible    " no legacy vi compatibility
set modelines=0     " prevent modelines security exploits by disabling them
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd         " Show (partial) command in status line
set hidden          " Hide buffers when they are abandoned
set wildmenu        " turn on wild menu :e <Tab>
set wildmode=list:longest
set visualbell      " 
set cursorline
set ttyfast         " we have a fast terminal
set ruler           " show the line number on the bar
set laststatus=2
set relativenumber

" appearance
colorscheme Mustang 
set background=dark
set gfn=Monaco:h14

" show invisible chars
"set list
"set listchars=tab:▸\ ,eol:¬

" Whitespace
set nowrap          " don't wrap lines
set tabstop=4 shiftwidth=4 " a tab is two spaces (or set this to 4)
set softtabstop=4
set expandtab       " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

" Searching/moving
nnoremap / /\v
vnoremap / /\v
set gdefault    " substitutions are global on lines
set showmatch   " Show matching brackets
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" remap leader key from default '/'
let mapleader = ","

" disable arrow keys (force me to do the right thing)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" auto save on focus lost
"au FocusLost * :wa

" map 'jj' to ESC in insert mode for quicker exiting
inoremap jj <ESC>

" open new vertical split and switch to it 
nnoremap <leader>w <C-w>v<C-w>l

" map <C-[h/j/k/l]> to move around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" swap ; and : so that you don't need shift to enter commandline mode
nore ; :
nore , ;

" PDI:
" peepopen
" nerdtree
" lusty explorer
" command-t
" nerdcommenter
" tpope's commenter
" ack
" snipmate
" yankring
" tpope's surround and repeat
" rainbow parenthesis
" fugitive (for git)
" fuzzyfinder
" commentary
" endwise
" markdown
" coffee-script

