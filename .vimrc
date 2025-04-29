set encoding=utf-8

"" Config
set number            " Show line numbers
set relativenumber    " User relative line numbersz
set linebreak         " Break lines at word (requires Wrap lines)
set showbreak=+++     " Wrap-broken line prefix
set textwidth=111     " Line wrap (number of cols)
set showmatch         " Highlight matching brace
set spell             " Enable spell-checking
set virtualedit=block " Enable free-range cursor
set visualbell        " Use visual bell (no beeping)

set hlsearch   " Highlight all search results
set smartcase  " Enable smart-case search
set ignorecase " Always case-insensitive
set incsearch  " Searches for strings incrementally

" (plugin for auto indent settings in use, these are defaults)
set autoindent    " Auto-indent new lines
set shiftwidth=2  " Number of auto-indent spaces
set smartindent   " Enable smart-indent
set smarttab      " Enable smart-tabs
set softtabstop=4 " Number of spaces per Tab

set ruler                      " Show row and column ruler information
set undolevels=1000            " Number of undo levels
set backspace=indent,eol,start " Backspace behaviour

" allow mouse
set mouse=a

" natural split openings
set splitbelow
set splitright
