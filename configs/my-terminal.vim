" TODO: move logic into autoload/; separate vifm, lf; simplify starting
" terminal (back to the :terminal command)

" Require `terminal` feature
if !has('terminal')
    finish
endif

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

command! -bang Ptpython call s:Ptpython(<bang>0)

" Common way to start terminal
func! s:terminal_start(command)
    let command = a:command
    let buf = term_start(command, {
        \ 'curwin': 1,
        \ 'term_finish': 'close',
        \ })
    if exists('*term_setkill')
        call term_setkill(buf, 'term')
    endif
    return buf
endfunc

" Run a wincmd before starting a terminal
func! s:start_terminal(command, wincmd) abort
    let command = empty(a:command)? input('Start command: '): a:command
    if !empty(command)
        let wincmd = empty(a:wincmd)? 'botright split': a:wincmd
        let curdir = my#project#dir()
        exec wincmd
        exec 'lcd '.fnameescape(curdir)
        return s:terminal_start(command)
    endif
endfunc

" Send lines to terminal
func! s:send_terminal(lines, waitcr) abort
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
endfunc

" Start a terminal without leaving current window
func! s:TerminalStart(...) abort
    let command = empty(a:000) ? '' : a:000[0]
    let winid = win_getid()
    call s:start_terminal(command, '')
    call win_gotoid(winid)
endfunc

" Start a terminal from results of fzf selection
func! s:handle_term(lines) abort
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
endfunc

" Get shells that are executable among common shells
func! s:get_shells()
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
endfunc

" Select a shell and a split option to start terminal with.
func! s:Shell(...) abort
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
endfunc

" Send selected range to terminal
func! s:TerminalSend(waitcr) abort range
    let lines = getline(a:firstline, a:lastline)
    call s:send_terminal(lines, a:waitcr)
endfunc

" Wait then send <CR> to update terminal
func! s:TerminalWaitCr() abort
    call s:send_terminal([], 1)
endfunc

func! s:Ptpython(nointeractive) abort
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
endfunc
