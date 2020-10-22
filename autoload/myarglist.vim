let s:my_arglist_name = 'my_arglist'

" Work with arglist
function! myarglist#Arglist() abort
    new
    call setbufvar('%', s:my_arglist_name, 1)
    nnoremap <silent> <buffer> <CR> :<C-u>call <SID>EditFile()<CR>
    call s:EnterArglist()
endfunction

" Open the file on current line
function! s:EditFile() abort
    let line = myfun#trim(getline('.'))
    if !empty(line)
        exec 'edit '.fnameescape(line)
    endif
endfunction

" If applicable, write arglist to current buffer
function! s:EnterArglist() abort
    if getbufvar('%', s:my_arglist_name)
        call deletebufline('%', 1, '$')
        let Getfullpath = {key, filename -> fnamemodify(filename, ':~')}
        let argfiles = map(argv(), Getfullpath)
        call append(0, argfiles)
        call cursor(1, 1)
    endif
endfunction

" If applicable, replace arglist with filenames from current buffer
function! s:LeaveArglist() abort
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

        bdelete!
    endif
endfunction

augroup my_arglist_augroup
  autocmd!
  autocmd BufEnter * :call s:EnterArglist()
  autocmd BufLeave * :call s:LeaveArglist()
augroup END
