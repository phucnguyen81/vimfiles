" Navigation using search and relative line numbers

" Not needed if easymotion is used
if exists('g:EasyMotion_loaded')
    finish
endif

" Jump to a location given line number, a text pattern and the position of the
" text in the line.
function! s:jump_to(line, text, position) abort
    let [line, text, pos] = [a:line, a:text, a:position]

    if line
        normal! m'
    endif
    if line > 0
        exec 'normal! '.(line).'gj'
    endif
    if line < 0
        exec 'normal! '.(-line).'gk'
    endif

    if !empty(text)
        call cursor(0, 1)
        call setreg('/', text)
        for i in range(1, max([1, pos]))
            if i == 1
                call search(text, 'c')
            else
                call search(text, 'z')
            endif
        endfor
    endif
endfunction

" Parse string containing optional [line] [pos] numbers
function! s:parse_line_pos(string) abort
    let [line, pos] = [-1, -1]
    for arg in split(a:string)
        if line < 0
            let line = str2nr(arg)
        elseif pos < 0
            let pos = str2nr(arg)
        else
            break
        endif
    endfor
    return [line, pos]
endfunction

" Parse string containing optional [line][text][pos].
" [text] can come before [line] if [text] contains non-digit characters.
function! s:parse_line_text_pos(string) abort
    let [line, text, pos] = [-1, '', -1]
    for arg in split(a:string)
        if match(arg, '\D') >= 0
            let text = arg
        elseif line < 0
            let line = str2nr(arg)
        elseif empty(text)
            let text = arg
        elseif pos < 0
            let pos = str2nr(arg)
        else
            break
        endif
    endfor
    return [line, text, pos]
endfunction

" Search downwards for current pattern in the search register.
" Let user enter relative line number and position of the pattern in the line.
function! s:search_down() abort
    let no_relativenumber = (exists('&relativenumber') && !&relativenumber)
    let no_hlsearch = (exists('&hlsearch') && !&hlsearch)
    try
        if no_relativenumber
            setlocal relativenumber
        endif
        if no_hlsearch
            setlocal hlsearch
        endif
        redraw

        let text = getreg('/')
        if empty(text)
            return
        endif

        let argline = input('[line][pos]: ')
        if empty(argline)
            return
        endif
        let [line, pos] = s:parse_line_pos(argline)
        call s:jump_to(line, text, pos)
    finally
        if no_relativenumber
            setlocal norelativenumber
        endif
        if no_hlsearch
            setlocal nohlsearch
        endif
    endtry
endfunction

" Search upwards for current pattern in the search register.
" Let user enter relative line number and position of the pattern in the line.
function! s:search_up() abort
    let no_relativenumber = (exists('&relativenumber') && !&relativenumber)
    let no_hlsearch = (exists('&hlsearch') && !&hlsearch)
    try
        if no_relativenumber
            setlocal relativenumber
        endif
        if no_hlsearch
            setlocal hlsearch
        endif
        redraw

        let text = getreg('/')
        if empty(text)
            return
        endif

        let argline = input('[line][pos]: ')
        if empty(argline)
            return
        endif
        let [line, pos] = s:parse_line_pos(argline)
        call s:jump_to(-line, text, pos)
    finally
        if no_relativenumber
            setlocal norelativenumber
        endif
        if no_hlsearch
            setlocal nohlsearch
        endif
    endtry
endfunction

" Jump downwards given line number, text pattern and its position in the line.
function! s:jump_down() abort
    let no_relativenumber = (exists('&relativenumber') && !&relativenumber)
    try
        if no_relativenumber
            setlocal relativenumber
        endif
        redraw

        let argline = input('[line][text][pos]: ')
        if empty(argline)
            return
        endif
        let [line, text, pos] = s:parse_line_text_pos(argline)
        call s:jump_to(line, text, pos)
    finally
        if no_relativenumber
            setlocal norelativenumber
        endif
    endtry
endfunction

" Jump upwards given line number, text pattern and its position in the line.
function! s:jump_up() abort
    let no_relativenumber = (exists('&relativenumber') && !&relativenumber)
    try
        if no_relativenumber
            setlocal relativenumber
        endif
        redraw

        let argline = input('[line][text][pos]: ')
        if empty(argline)
            return
        endif
        let [line, text, pos] = s:parse_line_text_pos(argline)
        call s:jump_to(-line, text, pos)
    finally
        if no_relativenumber
            setlocal norelativenumber
        endif
    endtry
endfunction

cnoremap <C-j> <CR>:<C-u>call <SID>search_down()<CR>
cnoremap <C-k> <CR>:<C-u>call <SID>search_up()<CR>
nnoremap <C-j> :<C-u>call <SID>jump_down()<CR>
nnoremap <C-k> :<C-u>call <SID>jump_up()<CR>
