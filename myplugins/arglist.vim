" Manage argument list

" Replace arglist with filenames from current buffer
function! s:UpdateArglist() abort
    " Delete all entries in arglist
    %argdelete

    " Add filenames from current buffer to arglist
    for line in getline(1, '$')
        let filename = trim(line)
        if filereadable(filename)
            exec 'argadd '.fnameescape(filename)
        endif
    endfor

    " Edit the first file in arglist
    if argc()
        0argument
    endif
endfunction

" Write arglist to a file.
function! s:EditArglist() abort
    let arglist_file = expand(g:my_vardir.'/'.v:servername.'.arglist')
    let arglist = argv(-1)
    call writefile(arglist, arglist_file)
    exec 'edit '.fnameescape(arglist_file)
endfunction

augroup my_arglist_augroup
  autocmd!
  autocmd BufLeave *.arglist :call <SID>UpdateArglist()
augroup END

command! Args call <SID>EditArglist()
nnoremap <Leader>ea :<C-u>call <SID>EditArglist()<CR>
