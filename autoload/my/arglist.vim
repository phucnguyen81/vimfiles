let s:my_arglist_name = 'my_arglist'

" Open the file on current line
func! s:EditFile() abort
    let line = myfun#trim(getline('.'))
    if !empty(line)
        exec 'edit '.fnameescape(line)
    endif
endfunc

" If applicable, write arglist to current buffer
func! s:EnterArglist() abort
    if getbufvar('%', s:my_arglist_name)
        %delete "_
        let Getfullpath = {key, filename -> fnamemodify(filename, ':~')}
        let argfiles = map(argv(), Getfullpath)
        call append(0, argfiles)
        call cursor(1, 1)
    endif
endfunc

" If applicable, replace arglist with filenames from current buffer
func! s:LeaveArglist() abort
    if getbufvar('%', s:my_arglist_name)
        " Delete all entries in arglist
        %argdelete

        " Add filenames from current buffer to arglist
        for line in getline(1, '$')
            let filename = expand(myfun#trim(line))
            if filereadable(filename)
                exec 'argadd '.fnameescape(filename)
            endif
        endfor

        bwipe!
    endif
endfunc

augroup my_arglist_augroup
  autocmd!
  autocmd BufEnter * :call s:EnterArglist()
  autocmd BufLeave * :call s:LeaveArglist()
augroup END

" Work with arglist
func! my#arglist#edit() abort
    new
    call setbufvar('%', s:my_arglist_name, 1)
    setlocal bufhidden=wipe buftype=nofile
    nnoremap <silent> <buffer> <CR> :<C-u>call <SID>EditFile()<CR>
    call s:EnterArglist()
endfunc
