source ~/.vimrc

" ================ NeoVim terminal =======================
:tnoremap <Esc> <C-\><C-n>
:tnoremap <A-h> <C-\><C-n><C-w>h
:tnoremap <A-j> <C-\><C-n><C-w>j
:tnoremap <A-k> <C-\><C-n><C-w>k
:tnoremap <A-l> <C-\><C-n><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

" ================ Ranger =======================
function! RangerMagic()
    bnew
    exec 'terminal ranger --choosefile=/tmp/chosenfile ' . expand("%:p:h")
    bdelete!
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfunction

function! RangerTest(dirname)
	if exists('g:rangered')
		let rangered = g:rangered
		unlet g:rangered

		if !filereadable(rangered)
			return
		endif

		let names = readfile(rangered)

		if empty(names)
			return
		endif

		exec 'tabe' . fnameescape(names[0])
        filetype detect

		for name in names[1:]
            exec 'tabe ' . fnameescape(name)
            filetype detect
        endfor
	elseif isdirectory(a:dirname)
		let g:rangered = '/tmp/chosenfile'
		new
		call termopen('ranger --choosefiles=' . shellescape(g:rangered) . ' ' . shellescape(a:dirname))
        startinsert
	endif
endfunction
