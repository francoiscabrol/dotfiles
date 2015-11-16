source ~/.vimrc

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

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

