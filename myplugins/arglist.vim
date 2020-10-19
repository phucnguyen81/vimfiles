" Edit the arglist file
function! s:EditArglist() abort
    let pid = getpid()
    let arglist_file = expand(g:my_vardir.'/vim_pid_'.pid.'.arglist')
    exec 'edit '.fnameescape(arglist_file)
endfunction

" Write arglist to current file
function! s:WriteArglist() abort
    let curfile = expand('%')
    if !filereadable(curfile)
        write
    endif
    let arglist = argv()
    call writefile(arglist, curfile)
    edit
endfunction

" Replace arglist with filenames from current buffer
function! s:UpdateArglist() abort
    " Delete all entries in arglist
    %argdelete

    " Add filenames from current buffer to arglist
    for line in getline(1, '$')
        " TODO trim() is not available in vim 8.0, add it to myfun
        " let filename = trim(line)
        let filename = line
        if filereadable(filename)
            exec 'argadd '.fnameescape(filename)
        endif
    endfor
endfunction

augroup my_arglist_augroup
  autocmd!
  autocmd BufEnter *.arglist :call <SID>WriteArglist()
  autocmd BufLeave *.arglist :call <SID>UpdateArglist()
augroup END

command! Args call <SID>EditArglist()
nnoremap <Leader>ea :<C-u>call <SID>EditArglist()<CR>
