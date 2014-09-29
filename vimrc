execute pathogen#infect()
syntax on
filetype plugin indent on

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

let g:vim_markdown_folding_disabled=1

set laststatus=2

set number
" eclude highlighting numbers for several plug-ins
let g:numbers_exclude = ['minibufexpl', 'nerdtree', 'unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']
nnoremap <F3> :NumbersToggle<CR>

map <C-n> :NERDTreeToggle<CR>

" Tag bar
nmap <F8> :TagbarToggle<CR>


"airline:
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
set guifont=MesloLGSDZ-RegularForPowerline
""let g:airline#extensions#tabline#left_sep = ' '
""let g:airline#extensions#tabline#left_alt_sep = '|'

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
