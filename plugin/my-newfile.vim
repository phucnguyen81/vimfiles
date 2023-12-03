" Things to do when creating new files.
" TODO: check if this is still relevant (should be handled by plugin)

" If current buffer is associated with a file,
" create parent directories of the file.
func! s:MakeParentDirs() abort
    let dir = expand('%:p:h')
    if empty(dir) || isdirectory(dir) || (dir =~ '://')
        return
    endif
    call mkdir(dir, 'p')
    echo 'Created directory: '.dir
endfunc

" Make parent directories when editing a new file.
augroup newfile_mkdir
    autocmd!
    autocmd BufNewFile * call s:MakeParentDirs()
augroup END
