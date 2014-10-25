execute pathogen#infect()
" switch syntax highlighting on, when the terminal has colors
syntax on

colorscheme molokai

" turn indentation on
filetype indent on

" enable filetype plugins
filetype plugin on

" specify syntax highlighting for specific files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" use vim, not vi api
set nocompatible

" no backup files
set nobackup

" no write backup
set nowritebackup

" no swap file
set noswapfile

" command history
set history=100

" always show cursor
set ruler

" show incomplete commands
set showcmd

" incremental searching
set incsearch

" highlight search
set hlsearch

" ignore case in search
set smartcase

" make sure any searches /searchPhrase doesn't need the \c escape character
set ignorecase

" a buffer is marked as ‘hidden’ if it has unsaved changes, and it is not currently loaded in a window
" if you try and quit Vim while there are hidden buffers, you will raise an error:
" E162 : No write since last change for buffer “a.txt”
set hidden

" disable folding because it is evil
set nofoldenable

" turn word wrap off
set nowrap

" scroll with more context
set scrolloff=10

" allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" convert tabs to spaces
set expandtab

" set tab size
set tabstop=4

" the number of spaces inserted for a tab
set shiftwidth=4

" turn on line numbers
set number

let g:vim_markdown_folding_disabled=1

" highlight tailing whitespace
set list listchars=tab:\ \ ,trail:·

" get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=1000 ttimeoutlen=100

" always show status bar
set laststatus=2

" set the status line to something useful
set statusline=%f\ %=L:%l/%L\ %c\ (%p%%)

" hide the toolbar
set guioptions-=T

" utf encoding
set encoding=utf-8

" autoload files that have changed outside of vim
set autoread

" use system clipboard
"http://stackoverflow.com/questions/8134647/copy-and-paste-in-vim-via-keyboard-between-different-mac-terminals
set clipboard+=unnamed

" don't show intro
set shortmess+=I

" better splits
set splitbelow
set splitright

" eclude highlighting numbers for several plug-ins
let g:numbers_exclude = ['minibufexpl', 'nerdtree', 'unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']
nnoremap <F2> :NumbersToggle<CR>

" F3 will open NERDTree panel and highlight current file. And when you're in
" the NERDTree panel, F3 will open file under cursor. So, I can use one button
" to jump between buffer and NERDTree. (And F4 for preview because it's next
" to F3)
map <F3> :NERDTreeToggle<CR>
map <F4> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

" Tag bar
nmap <F8> :TagbarToggle<CR>

" Vim javascript syntax
"au FileType javascript call JavaScriptFold()

"airline:
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
set guifont=Meslo\ LG\ M\ for\ Powerline
""let g:airline#extensions#tabline#left_sep = ' '
""let g:airline#extensions#tabline#left_alt_sep = '|'

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Indent-guide plugin:
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" NERDTree open automatically
""autocmd vimenter * NERDTree
" even id no files are specified
""autocmd StdinReadPre * let s:std_in=1
""autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the last panel is Nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" jump to last cursor
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

fun! StripTrailingWhitespace()
    " don't strip on these filetypes
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
