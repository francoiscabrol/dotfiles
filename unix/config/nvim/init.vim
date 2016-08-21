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
call plug#begin('~/.config/nvim/plugged')

Plug 'rbgrouleff/bclose.vim'
Plug 'vim-scripts/quickhl.vim'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/indentLine.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-peekaboo'
Plug 'matze/vim-move'
Plug 'mbbill/undotree'

Plug 'fatih/vim-go'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

"================ colors =======================
Plug 'lilydjwg/colorizer'
Plug 'KabbAmine/vCoolor.vim'

"================ languages =======================
"Bundle 'ktvoelker/sbt-vim'
"Plug 'Shutnik/jshint2.vim'
"Plug 'moll/vim-node'
"Plug 'heavenshell/vim-jsdoc'
"Plug 'othree/yajs.vim'
"Plug 'othree/javascript-libraries-syntax.vim'

"Plug 'mustache/vim-mustache-handlebars'
"Plug 'peterhoeg/vim-qml'
Plug 'wavded/vim-stylus'
"Plug 'briancollins/vim-jst'
"Plug 'groenewege/vim-less'
Plug 'hail2u/vim-css3-syntax'
Plug 'plasticboy/vim-markdown'
"Plug 'digitaltoad/vim-jade'
Plug 'aklt/plantuml-syntax'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
let g:deoplete#enable_at_startup = 1

"================ Git =======================
com! Undo :GitGutterUndoHunk
com! PreviewChanges :GitGutterPreviewHunk

"================ Colorscheme =======================
Plug 'NLKNguyen/papercolor-theme'
Plug 'w0ng/vim-hybrid'
Plug 'junegunn/seoul256.vim'
Plug 'trusktr/seti.vim'
Plug 'altercation/vim-colors-solarized'

Plug 'zefei/vim-colortuner'
"================ Motion =======================
"Plug 'Lokaltog/vim-easymotion'
" Add plugins to &runtimepath
call plug#end()

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

"================ Color palette =======================
let g:vcoolor_disable_mappings = 0

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

"================ Quckhl ========================
nmap <leader>j <Plug>(quickhl-manual-this)
xmap <leader>j <Plug>(quickhl-manual-this)
nmap <leader>k <Plug>(quickhl-cword-toggle)

"================ Easy align =======================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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
set hidden

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
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=list:longest

" allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" ================ Startify =======================
map <leader>s :Startify<CR>
autocmd User Startified setlocal buftype=
"let g:ctrlp_reuse_window = 'startify'
let g:startify_session_persistence = 1
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1

" ================ CtrP =======================
"nmap <C-b> :CtrlPBuffer<CR>

" ================ FZF =======================
nmap <C-p> :GitFiles<CR>
nmap <C-f> :FZF<CR>
nmap <C-b> :Buffers<CR>
nmap <C-c> :Commands<CR>
nmap <leader>t :Filetypes<CR>

" ================ Tabulation =======================
" convert tabs to spaces
set expandtab

" set tab size
set tabstop=2

" the number of spaces inserted for a tab
set shiftwidth=2

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
nnoremap <Leader>q :q<CR>:cclose<CR>
nnoremap <C-q> :q<CR>:cclose<CR>

" Save file with SPACE + w
nnoremap <Leader>w :w<CR>
nnoremap <C-s> :w<CR>

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
"vmap <C-c> y
"nmap <C-c> yy

" don't show intro
"set shortmess+=I

" ================ Split =======================
" better splits
set splitbelow
set splitright

" Tired of clearing highlighted searches by searching for “ldsfhjkhgakjks”? Use this:
nmap <silent> <leader>/ :nohlsearch<CR>:cclose<CR>:QuickhlManualReset<CR>

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
let g:ranger_map_keys = 1

" ================ TagBar=======================

" Quickly edit/reload the vimrc file
nmap <silent> <leader>e :e $MYVIMRC<CR>
nmap <silent> <leader>r :so $MYVIMRC<CR>

" Delete buffer when they are hidden
"autocmd BufEnter * set bufhidden=delete

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

function! MyTabFilename(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufnum = buflist[winnr - 1]
  let bufname = expand('#'.bufnum.':t')
  let buffullname = expand('#'.bufnum.':p')
  let buffullnames = []
  let bufnames = []
  for i in range(1, tabpagenr('$'))
    if i != a:n
      let num = tabpagebuflist(i)[tabpagewinnr(i) - 1]
      call add(buffullnames, expand('#' . num . ':p'))
      call add(bufnames, expand('#' . num . ':t'))
    endif
  endfor
  let i = index(bufnames, bufname)
  if strlen(bufname) && i >= 0 && buffullnames[i] != buffullname
    return substitute(buffullname, '.*/\([^/]\+/\)', '\1', '')
  else
    return strlen(bufname) ? bufname : '[No Name]'
  endif
endfunction

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'right': [ [ 'lineinfo' ], ['percent'], [ 'filetype' ] ]
            \ },
            \ 'component': {
            \   'readonly': '%{&readonly?"":""}',
            \ },
            \ 'tab_component_function': {
            \   'filename': 'MyTabFilename',
            \ },
            \ 'component_function': {
            \   'modified': 'LightLineModified',
            \   'filename': 'LightLineFilename'
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '|', 'right': '|' }
            \ }

"================ Colors and theme ========================
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
colorscheme seoul256
if $BG == 'dark'
    set background=dark
else
    set background=light
endif

 "================ Syntastic =======================
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0


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
let g:quickhl_manual_colors = [
    \ "gui=bold ctermfg=16   ctermbg=153 guibg=#747070 guibg=#ffffff",
    \ "gui=bold ctermfg=16   ctermbg=1   guibg=#FFBC78 guifg=#ffffff",
    \ "gui=bold ctermfg=16   ctermbg=2   guibg=#72B9FF guifg=#ffffff",
    \ "gui=bold ctermfg=16   ctermbg=3   guibg=#3EA06F guifg=#ffffff",
    \ ]
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" ================ Pane separator =======================
" set fillchars+=vert:\

" Override color scheme to make split the same color as tmux's default
"autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=white ctermbg=NONE
"highlight VertSplit cterm=NONE ctermfg=NONE ctermbg=white

" ================ Custom command =======================

" Selecting all the file content
:map <C-a> ggVG$
" tab navigation
:map <A-h> :tabprevious<CR>
:map <A-l> :tabnext<CR>
:map <A-left> :tabprevious<CR>
:map <A-right> :tabnext<CR>

" ================ NeoVim terminal =======================
:tnoremap <Esc> <C-\><C-n>
:tnoremap <C-h> <C-\><C-n><C-w>h
:tnoremap <C-j> <C-\><C-n><C-w>j
:tnoremap <C-k> <C-\><C-n><C-w>k
:tnoremap <C-l> <C-\><C-n><C-w>l
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l

:map <A-left> <A-h>
:map <A-right> <A-l>
:map <A-up>   <A-k>
:map <A-down> <A-j>

