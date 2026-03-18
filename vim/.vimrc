" ============================================================
"  Basic Vim Configuration (~/.vimrc)
" ============================================================

" --- General ---
set nocompatible            " Disable Vi compatibility mode
set encoding=utf-8          " Use UTF-8 encoding
set history=500             " Keep 500 lines of command history
set autoread                " Auto-reload files changed outside Vim
set hidden                  " Allow switching buffers without saving

" --- UI ---
set number                  " Show line numbers
set relativenumber          " Relative line numbers
set cursorline              " Highlight current line
set showmatch               " Highlight matching brackets
set wildmenu                " Enhanced command-line completion
set ruler                   " Show cursor position in status bar
set showcmd                 " Show incomplete commands
set laststatus=2            " Always show status line
set scrolloff=8             " Keep 8 lines above/below cursor

" --- Search ---
set hlsearch                " Highlight search results
set incsearch               " Incremental search (search as you type)
set ignorecase              " Case-insensitive search...
set smartcase               " ...unless query contains uppercase

" --- Indentation ---
set tabstop=4               " Tab = 4 spaces visually
set shiftwidth=4            " Indent by 4 spaces
set softtabstop=4           " Backspace deletes 4 spaces
set expandtab               " Use spaces instead of tabs
set autoindent              " Copy indent from current line
set smartindent             " Smart auto-indenting

" --- Wrapping ---
set nowrap                  " Don't wrap long lines
set linebreak               " If wrap is on, break at word boundaries

" --- Splits ---
set splitright              " Vertical split opens to the right
set splitbelow              " Horizontal split opens below

" --- Performance ---
set lazyredraw              " Don't redraw during macros
set ttyfast                 " Faster terminal rendering

" --- Backups ---
set noswapfile              " Disable swap files
set nobackup                " Disable backup files
set undofile                " Persistent undo history
set undodir=~/.vim/undodir  " Directory to store undo files

" --- Syntax & Colors ---
syntax enable               " Enable syntax highlighting
set background=dark         " Use dark background
colorscheme desert          " Built-in colorscheme (change as needed)

" --- Key Mappings ---
let mapleader = " "         " Set leader key to Space

" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>

" Save and quit shortcuts
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Better indentation in visual mode (keeps selection)
vnoremap < <gv
vnoremap > >gv

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" --- File Type Settings ---
filetype plugin indent on   " Enable filetype detection & plugins

autocmd FileType python     setlocal tabstop=4 shiftwidth=4
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType html       setlocal tabstop=2 shiftwidth=2
autocmd FileType css        setlocal tabstop=2 shiftwidth=2
autocmd FileType yaml       setlocal tabstop=2 shiftwidth=2
