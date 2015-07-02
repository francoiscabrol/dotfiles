" Required Vundle setup
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Shutnik/jshint2.vim'
Bundle 'tomasr/molokai'
Bundle 'scrooloose/nerdtree'
Bundle 'aklt/plantuml-syntax'
Bundle 'ktvoelker/sbt-vim'
Bundle 'ervandew/screen'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'
Bundle 'mtscout6/vim-tagbar-css'
Bundle 'marijnh/tern_for_vim'
Bundle 'bling/vim-airline'
Bundle 'kchmck/vim-coffee-script'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'airblade/vim-gitgutter'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'digitaltoad/vim-jade'
Bundle 'pangloss/vim-javascript'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'briancollins/vim-jst'
Bundle 'groenewege/vim-less'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'plasticboy/vim-markdown'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'moll/vim-node'
Bundle 'wavded/vim-stylus'
Bundle 'lepture/vim-velocity'
Bundle 'wannesm/wmgraphviz.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'francoiscabrol/vim-grep'
Bundle 'vim-scripts/indentLine.vim'
Bundle 'mileszs/ack.vim'
Bundle 'trusktr/seti.vim'
Bundle 'peterhoeg/vim-qml'

" Eleminate delay with Esc
set esckeys

" switch syntax highlighting on, when the terminal has colors
syntax on

colorscheme molokai
" let g:molokai_original = 1

set background=dark
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
let g:rehash256 = 1
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" turn indentation on
filetype indent on

" enable filetype plugins
filetype plugin on

" specify syntax highlighting for specific files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" use vim, not vi api
set nocompatible

" use mouse
set mouse=a

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

" Set line highlighting
set cursorline
hi CursorLine ctermbg=black

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

" No visual error or sound
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" a buffer is marked as ‘hidden’ if it has unsaved changes, and it is not currently loaded in a window
" if you try and quit Vim while there are hidden buffers, you will raise an error:
" E162 : No write since last change for buffer “a.txt”
"set hidden

" disable folding because it is evil
set nofoldenable

" turn word wrap off
" set nowrap

" scroll with more context
" set scrolloff=10

" allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" convert tabs to spaces
set expandtab

" set tab size
set tabstop=4
au BufNewFile,BufRead *.scala set tabstop=2

" the number of spaces inserted for a tab
set shiftwidth=4

" turn on line numbers
"set number

let g:vim_markdown_folding_disabled=1

" highlight tailing whitespace
set list listchars=tab:\ \ ,trail:·

" get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=200 ttimeoutlen=200

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

" map leader to SPACE
" let mapleader = "\<Space>"

" Close file with SPACE + q
nnoremap <Leader>q :q<CR>

" Save file with SPACE + w
nnoremap <Leader>w :w<CR>

" use system clipboard
set clipboard+=unnamed
" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <C-c> "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Stop that stupid window from popping up:
map q: :q

" don't show intro
" set shortmess+=I

" better splits
set splitbelow
set splitright

" Tired of clearing highlighted searches by searching for “ldsfhjkhgakjks”? Use this:
nmap <silent> <leader>/ :nohlsearch<CR>

" eclude highlighting numbers for several plug-ins
"let g:numbers_exclude = ['minibufexpl', 'nerdtree', 'unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']
"nnoremap <F2> :NumbersToggle<CR>

" F3 will open NERDTree panel and highlight current file. And when you're in
" the NERDTree panel, F3 will open file under cursor. So, I can use one button
" to jump between buffer and NERDTree. (And F4 for preview because it's next
" to F3)
" nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTree<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" Tag bar
nmap <F8> :TagbarToggle<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Delete buffer when they are hidden
autocmd BufEnter * set bufhidden=delete

" Move lines
nnoremap <C-j> : m .+1<CR>
nnoremap <C-k> : m .-2<CR>
vnoremap <C-k> : m '<-2<CR>gv=gv
vnoremap <C-j> : m '>+1<CR>gv=gv

" Write a file with the sudo right
cmap w!! w !sudo tee % >/dev/null

" Airline:
" Enable/disable displaying tab number in tabs mode. >
let g:airline#extensions#tabline#show_tab_nr   = 0
let g:airline#extensions#tabline#tab_min_count = 2
" Enable/disable displaying buffers with a single tab. >
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#enabled      = 1
let g:airline_powerline_fonts                 = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='luna'
set guifont=Meslo\ LG\ M\ for\ Powerline


hi Visual guibg=#002b36

" tabs keys mapping
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
nnoremap th :tabnext<CR>
nnoremap tl :tabprev<CR>
nnoremap tn :tabnew<CR>

" Indent-guide plugin:
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

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

" jshint
set runtimepath+=~/.vim/bundle/jshint2.vim/
