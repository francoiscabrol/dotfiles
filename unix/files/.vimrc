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

" utf encoding
" commented because neovim " set encoding=utf-8

" autoload files that have changed outside of vim
set autoread

" get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=200 ttimeoutlen=200

" No visual error or sound
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"================ Plug-ins ========================
" Required Vundle setup
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/Vundle.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'
Bundle 'mtscout6/vim-tagbar-css'
Bundle 'itchyny/lightline.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'airblade/vim-gitgutter'
Bundle 'vim-scripts/indentLine.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'wannesm/wmgraphviz.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'francoiscabrol/vim-grep'
Bundle 'mileszs/ack.vim'
Bundle 'mhinz/vim-startify'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'junegunn/goyo.vim'
Bundle 'junegunn/limelight.vim'
Bundle 'zefei/vim-colortuner'
Bundle 'jaxbot/semantic-highlight.vim'

"================ colors =======================
Bundle 'lilydjwg/colorizer'
Bundle 'KabbAmine/vCoolor.vim'

"================ languages =======================
Bundle 'ktvoelker/sbt-vim'
Bundle 'Shutnik/jshint2.vim'
"Bundle 'marijnh/tern_for_vim'
Bundle 'moll/vim-node'
Bundle 'heavenshell/vim-jsdoc'
Bundle 'othree/yajs.vim'
Bundle 'othree/javascript-libraries-syntax.vim'

Bundle 'mustache/vim-mustache-handlebars'
Bundle 'peterhoeg/vim-qml'
Bundle 'wavded/vim-stylus'
Bundle 'briancollins/vim-jst'
Bundle 'groenewege/vim-less'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'plasticboy/vim-markdown'
Bundle 'digitaltoad/vim-jade'
Bundle 'aklt/plantuml-syntax'

"================ colorscheme =======================
Bundle 'NLKNguyen/papercolor-theme'
Bundle 'w0ng/vim-hybrid'
Bundle 'junegunn/seoul256.vim'
Bundle 'trusktr/seti.vim'
Bundle 'altercation/vim-colors-solarized'

"================ Motion =======================
Bundle 'Lokaltog/vim-easymotion'
" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" enable filetype plugins

filetype plugin on
"================ Shortcuts =======================
" Eleminate delay with Esc
set esckeys

"================ Syntax highlighting =======================
syntax on

" specify syntax highlighting for specific files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Set line highlighting
set cursorline
hi CursorLine ctermbg=lightgrey

" always show cursor
set ruler

"================ Colors and theme ========================
colorscheme hybrid
if $BG == 'dark'
    set background=dark
else
    set background=light
endif
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

"================ Color palette =======================
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<leader>c'

"================ Indentation ========================
" turn indentation on
filetype indent on

" indend / deindent after selecting the text with (⇧ v), (.) to repeat.
vnoremap <Tab> >
vnoremap <S-Tab> <

" Indent-guide plugin:
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

"================ Tabular =======================
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

"================ Comments =======================
noremap <C-/> :NERDComToggleComment<CR>


"================ Search  =======================

" incremental searching
set incsearch

" highlight search
set hlsearch

" ignore case in search
set smartcase

" make sure any searches /searchPhrase doesn't need the \c escape character
set ignorecase

"================ Buffers =======================

" a buffer is marked as ‘hidden’ if it has unsaved changes, and it is not currently loaded in a window
" if you try and quit Vim while there are hidden buffers, you will raise an error:
" E162 : No write since last change for buffer “a.txt”
"set hidden

"================ Folding =======================
" disable folding because it is evil
set nofoldenable

let g:vim_markdown_folding_disabled=1

" turn word wrap off
" set nowrap

" ================ Command =======================
" command history
set history=100

" show incomplete commands
set showcmd

" config command completion
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches

" allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" ================ Startify =======================
map <leader>s :Startify<CR>
autocmd User Startified setlocal buftype=
let g:ctrlp_reuse_window = 'startify'
let g:startify_session_persistence = 1
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1

" ================ CtrP =======================
nmap <C-b> :CtrlPBuffer<CR>

" ================ Tabulation =======================
" convert tabs to spaces
set expandtab

" set tab size
set tabstop=4

" the number of spaces inserted for a tab
set shiftwidth=4

" Set exception for Scala
au BufNewFile,BufRead *.scala set tabstop=2

" turn on line numbers
"set number

" ================ Edition rules =======================
" highlight tailing whitespace
set list listchars=tab:\ \ ,trail:·

" ================ Status line =======================
" always show status bar
set laststatus=2

" Don't show the buildin vim information line
set noshowmode

" set the status line to something useful
set statusline=\ %f%m%r%h%w\ %=%({%{&ff}\|%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%k\|%Y}%)\ %([%l,%v][%p%%]\ %)

" ================ vim GUI =======================
" hide the toolbar
set guioptions-=T

" ================ Alias =======================
" Close file with SPACE + q
nnoremap <Leader>q :q<CR>
nnoremap <C-q> :q<CR>

" Save file with SPACE + w
nnoremap <Leader>w :w<CR>

" Stop that stupid window from popping up:
map q: :q

" ================ Clipboard =======================
" use system clipboard
set clipboard^=unnamedplus
set clipboard^=unnamed

" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "-y
vmap <Leader>d "-d
nmap <Leader>p "-p
nmap <Leader>P "-P
" Cut, Paste, Copy
vmap <C-x> d
map <C-x> dd
" map <C-v> P
vmap <C-c> y
nmap <C-c> yy

" don't show intro
"set shortmess+=I

" ================ Split =======================
" better splits
set splitbelow
set splitright

" Tired of clearing highlighted searches by searching for “ldsfhjkhgakjks”? Use this:
nmap <silent> <leader>/ :nohlsearch<CR>:cclose<CR>

" ================ NERDTree =======================
" Make nerdtree look nice
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30

" F3 will open NERDTree panel and highlight current file. And when you're in
" the NERDTree panel, F3 will open file under cursor. So, I can use one button
" to jump between buffer and NERDTree. (And F4 for preview because it's next
" to F3)
" nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTree<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" ================ Ranger =======================
fun! RangerChooser()
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
map <leader>f :call RangerChooser()<CR>

" ================ TagBar=======================
nmap <leader>t :TagbarToggle<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>e :e $MYVIMRC<CR>
nmap <silent> <leader>r :so $MYVIMRC<CR>

" Delete buffer when they are hidden
autocmd BufEnter * set bufhidden=delete

" Write a file with the sudo right
cmap w!! w !sudo tee % >/dev/null

"" Airline:
"" Enable/disable displaying tab number in tabs mode. >
"let g:airline#extensions#tabline#show_tab_nr   = 0
"let g:airline#extensions#tabline#tab_min_count = 2
"" Enable/disable displaying buffers with a single tab. >
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline#extensions#tabline#enabled      = 1
"let g:airline_powerline_fonts                 = 1
"" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline_theme='luna'
set guifont=Meslo\ LG\ M\ for\ Powerline
"
"" enable/disable syntastic integration
"let g:airline#extensions#syntastic#enabled = 1

" ================ Lightline =======================
function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineFilename()
  return expand('%')
endfunction

let g:lightline = {
            \ 'active': {
            \   'right': [ [ 'lineinfo' ], ['percent'], [ 'filetype' ] ]
            \ },
            \ 'component': {
            \   'readonly': '%{&readonly?"":""}',
            \ },
            \ 'component_function': {
            \   'modified': 'LightLineModified',
            \   'filename': 'LightLineFilename'
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '|', 'right': '|' }
            \ }

            "\ 'separator': { 'left': '', 'right': '' },
            "\ 'subseparator': { 'left': '', 'right': '' }
            "
" ================ Syntastic =======================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


" tabs keys mapping
nnoremap <C-t>  :tabnew<CR>
inoremap <C-t>  <Esc>:tabnew<CR>i
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>

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

"======= JSON =========
com! FormatJSON %!jq .
"Use :FormatJSON to format json
