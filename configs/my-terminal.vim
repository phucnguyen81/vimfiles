" NOTE: Require `terminal` feature
" TODO: move logic into autoload/; separate vifm, lf; simplify starting
" terminal (back to the :terminal command)

" Shortcut to escape to normal mode
tnoremap <C-\><C-\> <C-\><C-n>

command! -nargs=? Shell call s:Shell(<f-args>)
nnoremap <Leader>sh :<C-u>call <SID>Shell()<CR>

command! -nargs=? Term call s:TerminalStart(<f-args>)

command! -bang -range TermSend <line1>,<line2>call s:TerminalSend(<bang>0)
nnoremap <C-s><C-s> :call <SID>TerminalSend(0)<CR>
nnoremap <C-s><C-e> :call <SID>TerminalWaitCr()<CR>
nnoremap <Leader>ts :call <SID>TerminalSend(0)<CR>
xnoremap <C-s><C-s> :call <SID>TerminalSend(0)<CR>
xnoremap <C-s><C-e> :call <SID>TerminalSend(1)<CR>
xnoremap <Leader>ts :call <SID>TerminalSend(0)<CR>

command! Vifm call <SID>Vifm()
nnoremap <Leader>vf :call <SID>Vifm()<CR>
command! Vifmc call <SID>Vifmc()
command! Lf call <SID>Lf()

command! -bang Ptpython call s:Ptpython(<bang>0)

" Common way to start terminal
function! s:terminal_start(command)
    let command = a:command
    let buf = term_start(command, {
        \ 'curwin': 1,
        \ 'term_finish': 'close',
        \ })
    if exists('*term_setkill')
        call term_setkill(buf, 'term')
    endif
    return buf
endfunction

" Run a wincmd before starting a terminal
function! s:start_terminal(command, wincmd) abort
    let command = a:command
    let wincmd = a:wincmd

    if empty(command)
        let command = input('Start command: ')
    endif
    if empty(command)
        return
    endif

    let curdir = my#project#dir()
    if empty(wincmd)
        call myfun#split_window()
    else
        exec wincmd
    endif
    exec 'lcd '.fnameescape(curdir)

    return s:terminal_start(command)
endfunction

" Send lines to terminal
function! s:send_terminal(lines, waitcr) abort
    let lines = a:lines
    let waitcr = a:waitcr

    " Find a terminal buffer in current tab
    let tabnr = tabpagenr()
    let buf = 0
    for window in getwininfo()
        if window.tabnr == tabnr && window.terminal
            let buf = window.bufnr
            break
        endif
    endfor

    " Open a terminal buffer if needed
    if !buf
        let winid = win_getid()
        let buf = s:start_terminal('', '')
        call win_gotoid(winid)
    endif

    for line in lines
        call term_sendkeys(buf, line)
        call term_sendkeys(buf, "\<CR>")
    endfor
    if waitcr
        call term_wait(buf, 200)
        call term_sendkeys(buf, "\<CR>")
    endif
endfunction

" Start a terminal without leaving current window
function! s:TerminalStart(...) abort
    let command = empty(a:000) ? '' : a:000[0]
    let winid = win_getid()
    call s:start_terminal(command, '')
    call win_gotoid(winid)
endfunction

" Start a terminal from results of fzf selection
function! s:handle_term(lines) abort
    let lines = a:lines
    let linecount = len(lines)
    if linecount < 2
        return
    endif

    let query = lines[0]
    let key = lines[1]
    let command = linecount > 2 ? lines[2] : ''
    if empty(command) || executable(query)
        let command = query
    endif
    if executable(command.'.exe')
        let command = command.'.exe'
    endif

    if key ==? 'ctrl-t'
        let wincmd = '-tabnew'
    elseif key ==? 'ctrl-x'
        let wincmd = 'split'
    elseif key ==? 'ctrl-v'
        let wincmd = 'vsplit'
    else
        let wincmd = ''
    endif

    call s:start_terminal(command, wincmd)
endfunction

" Get shells that are executable among common shells
function! s:get_shells()
    let all_shells = [
        \ 'bash',
        \ 'cmd', 'powershell', 'pwsh',
        \ 'node', 'python', 'ptpython',
        \ ]
    let shells = []
    for cmd in all_shells
        if executable(cmd)
            call add(shells, cmd)
        endif
    endfor
    return sort(shells)
endfunction

" Select a shell and a split option to start terminal with.
function! s:Shell(...) abort
    if !empty(a:000)
        call s:start_terminal(a:000[0], '')
        return
    endif

    let source = s:get_shells()
    let fzf_options = [
        \ '--prompt', 'Shell command: ',
        \ '--reverse', '--print-query',
        \ '--expect=ctrl-t,ctrl-x,ctrl-v',
        \ ]

    let options = {
        \ 'source': source,
        \ 'sink*': funcref('s:handle_term'),
        \ 'options': fzf_options
        \ }
    let options = fzf#wrap(options)
    call fzf#run(options)
endfunction

" Send selected range to terminal
function! s:TerminalSend(waitcr) abort range
    let lines = getline(a:firstline, a:lastline)
    call s:send_terminal(lines, a:waitcr)
endfunction

" Wait then send <CR> to update terminal
function! s:TerminalWaitCr() abort
    call s:send_terminal([], 1)
endfunction

function! s:Ptpython(nointeractive) abort
    let interactive = !a:nointeractive
    let curfile = myfun#current_file()
    let iarg = ''
    if interactive && &filetype ==? 'python' && filereadable(curfile)
        let iarg = '--interactive="'.curfile.'"'
    endif

    let winid = win_getid()
    try
        call s:start_terminal('ptpython '.iarg, '')
    finally
        if !interactive
            call win_gotoid(winid)
        endif
    endtry
endfunction

function! s:Vifm() abort
    let curfile = myfun#current_file()
    if empty(curfile)
        let left_side = '.'
    else
        let left_side = '--select "'.curfile.'"'
    endif
    let curdir = my#project#dir()

    -tabnew
    exec 'lcd '.fnameescape(curdir)
    let command = join(['vifm', left_side, '.'])
    call s:terminal_start(command)
endfunction

" Show files selected with vifm
function! s:Vifmc() abort
    let curdir = my#project#dir()

    -tabnew
    exec 'lcd '.fnameescape(curdir)
    let tmpfile = tempname()
    exec 'edit '.fnameescape(tmpfile)
    write
    autocmd BufEnter <buffer> edit!

    -tabnew
    let command = 'vifm --choose-files "'.tmpfile.'" .'
    call s:terminal_start(command)
endfunction

function! s:Lf() abort
    let curdir = my#project#dir()

    -tabnew
    exec 'lcd '.fnameescape(curdir)
    call s:terminal_start('lf')
endfunction
