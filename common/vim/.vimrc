" Set encoding
set encoding=utf-8

" Enable syntax highlighting
syntax enable

" Set/Create directory for swap files
set directory=$HOME/.cache/vim/swap//
" Create swap directory if it doesn't exist
if !isdirectory(&directory)
    call mkdir(&directory, "p", 0700)
endif

" Enable buffer switching
set hidden

" Enable smart indentation
set smartindent

" Use 2 spaces for indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Enable mouse support
set mouse=a

" Search options
set ignorecase
set smartcase
set incsearch
set hlsearch

" Don't wrap lines
set nowrap

" Keep some context when scrolling
set scrolloff=5

" Show command in bottom bar
set showcmd

" Status line
set laststatus=2

" No annoying sound on errors
set noerrorbells
set novisualbell

" Show matching brackets
set showmatch

" Set colorscheme
colorscheme slate

" Highlight current line
set cursorline

" Show invisible characters
set nolist
set listchars=tab:›\ ,trail:·,lead:·,extends:»,precedes:«,nbsp:␣

" Use a subtle color for invisible characters
highlight SpecialKey ctermfg=black
highlight NonText ctermfg=black

" Conceal settings
set conceallevel=2
set concealcursor=nc
