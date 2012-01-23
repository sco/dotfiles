" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

set nocompatible          " no legacy compat. must be first.

call pathogen#infect()
filetype plugin indent on " load file type plugins + indentation

set modelines=0           " prevent modelines security exploits by disabling them
set encoding=utf-8

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

syntax enable
set background=dark
colorscheme solarized

set encoding=utf-8
set scrolloff=8            " provide context when editing
set autoread               " reload files (no local changes only)
set showmode               " Show current mode down the bottom
set hidden                 " Hide buffers when they are abandoned
set cursorline             " highlight current line
set laststatus=2           " Show the status line all the time
set ruler                  " show the cursor position all the time
set ttyfast                " we have a fast terminal
set showcmd                " display incomplete commands
#set nolazyredraw           " turn off lazy redraw
set relativenumber         " show relative line numbers
set wildmenu               " turn on wild menu :e <Tab>
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling
set gdefault               " substitutions are global on lines
set backspace=indent,eol,start  " backspace through everything in insert mode

" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch              " brackets/braces that is
set mat=5                  " duration to show matching brace (1/10 sec)
set laststatus=2           " always show the status line
set visualbell             " shut the fuck up

set hlsearch               " highlight matches
set incsearch              " incremental searching
set ignorecase             " searches are case insensitive...
set smartcase              " ... unless they contain at least one capital letter

" ----------------------------------------------------------------------------
"  Text Formatting
" ----------------------------------------------------------------------------

set autoindent
set smartindent
set nowrap                 " don't wrap lines
set tabstop=2 shiftwidth=2 " a tab is two spaces (or set this to 4)
set softtabstop=2
set expandtab              " use spaces, not tabs (optional)

" show invisible chars
set list
set listchars=tab:▸\ ,eol:¬

" ----------------------------------------------------------------------------
"  Backups
" ----------------------------------------------------------------------------

set nobackup                           " do not keep backups after close
set nowritebackup                      " do not keep a backup while working
set noswapfile                         " don't keep swp files either
set backupdir=$HOME/.vim/backup        " store backups under ~/.vim/backup
set backupcopy=yes                     " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap,~/tmp,.      " keep swp files under ~/.vim/swap

" ---------------------------------------------------------------------------
" Mappings 
" ---------------------------------------------------------------------------

" remap leader key from default '\'
let mapleader = ","

" clear search buffer on return
nnoremap <CR> :noh<cr>

nnoremap <tab> %
vnoremap <tab> %

" start searches with \v to disable vim-specific regex
nnoremap / /\v
vnoremap / /\v

" disable arrow keys (force me to do the right thing)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" what do these do?
"nnoremap j gj<CR>
nnoremap k gk

" map 'jj' to ESC in insert mode for quicker exiting
inoremap jj <ESC>

" open new vertical split and switch to it 
nnoremap <leader>w <C-w>v<C-w>l

" map <C-[h/j/k/l]> to move around splits
"nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" map <C-h> to :FufHelp (fuzzyfinder help)
nnoremap <C-h> :FufHelp<CR>

" ---------------------------------------------------------------------------
" Autocommands
" ---------------------------------------------------------------------------

" auto save on focus lost
"au FocusLost * :wa

" ---------------------------------------------------------------------------
" Filetypes
" ---------------------------------------------------------------------------

" Set File type to 'text' for files ending in .txt
autocmd BufNewFile,BufRead *.txt setfiletype text

" Enable soft-wrapping for text files
autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

" ---------------------------------------------------------------------------
"  Open URL on current line in browser
" ---------------------------------------------------------------------------

function! Browser ()
    let line0 = getline (".")
    let line = matchstr (line0, "http[^ )]*")
    let line = escape (line, "#?&;|%")
    exec ':silent !open ' . "\"" . line . "\""
endfunction
map <leader>w :call Browser ()<CR>

" ---------------------------------------------------------------------------
" PDI
" ---------------------------------------------------------------------------

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

" ---------------------------------------------------------------------------
" Reference
" ---------------------------------------------------------------------------

" http://mislav.uniqpath.com/2011/12/vim-revisited/
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#getting-started
" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
" http://mislav.uniqpath.com/2011/12/vim-revisited/
" https://github.com/ryanb/dotfiles
" https://github.com/rtomayko/dotfiles/blob/rtomayko/.vimrc

