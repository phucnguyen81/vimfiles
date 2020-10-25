" Session management

if !exists('g:my_session_dir')
    finish
endif

command! -nargs=0 Sessions exec 'edit '.fnameescape(g:my_session_dir)
nnoremap <Leader>ss :call <SID>sessions()<CR>

function! s:sessions() abort
    let session_files = globpath(g:my_session_dir, '*.vim', 1, 1)
    let session_names = []
    for session in session_files
        call add(session_names, fnamemodify(session, ':t:r'))
    endfor
    let options = [
        \ '--multi',
        \ '--print-query',
        \ '--bind=change:top,esc:cancel,ctrl-g:cancel,ctrl-y:backward-kill-word',
        \ '--expect=ctrl-n,ctrl-d,ctrl-s,ctrl-x,ctrl-e',
        \ ]
    if !empty(v:this_session)
        let current_session = fnamemodify(v:this_session, ':t:r')
        call add(options, '--query='.current_session)
    endif
    let fzf_options = {
        \ 'source': session_names,
        \ 'sink*': funcref('s:read_session'),
        \ 'options': options,
        \ }
    call fzf#run(fzf_options)
endfunction

function! s:read_session(items) abort
    if empty(a:items)
        return
    endif

    let [query, keypress; selections] = a:items

    if keypress ==? 'ctrl-x'
        exec 'Lexplore '.fnameescape(g:my_session_dir)
        return
    endif

    let session_files = []
    for session_name in selections
        let session_file = findfile(
            \ session_name.'.vim', g:my_session_dir)
        if filereadable(session_file)
            call add(session_files, session_file)
        endif
    endfor

    if keypress ==? 'ctrl-e' && !empty(session_files)
        for session_file in session_files
            exec 'edit '.fnameescape(session_file)
        endfor
    endif

    if keypress ==? 'ctrl-s' && !empty(session_files)
        for session_file in session_files
            exec 'mksession! '.fnameescape(session_file)
        endfor
    endif

    if keypress ==? 'ctrl-d' && !empty(session_files)
        for session_file in session_files
            call delete(session_file)
            echom 'Delete session: '.session_file
        endfor
    endif

    if !empty(query) && keypress ==? 'ctrl-n' && empty(selections)
        let session_name = query
        if fnamemodify(query, ':e') !=? 'vim'
            let session_name = session_name.'.vim'
        endif
        let session_file = expand(g:my_session_dir.'/'.session_name)
        exec 'mksession '.session_file
        echom 'Make new session: '.session_name
    endif

    if empty(keypress) && !empty(selections)
        for session_file in session_files
            exec ':source '.fnameescape(session_file)
        endfor
    endif
endfunction
