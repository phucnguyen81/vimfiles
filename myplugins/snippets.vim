" Read a snippet from 'snippets' directory into current buffer.
" The snippet is searched for using the word under cursor and
" the current file extension.
function! s:ReadSnippet() abort
    let filename = expand('<cWORD>')
    let extension = expand('%:e')
    let snippet1 = findfile(filename, g:my_snippets)
    let snippet2 = findfile(filename.'.'.extension, g:my_snippets)
    let snippet = empty(snippet1) ? snippet2 : snippet1
    if filereadable(snippet)
        normal! diW
        exec '-1read '.fnameescape(snippet)
        normal! W
        return
    endif
    let snipname = filename 
    if (match(snipname, '\.') == -1) && !empty(extension)
        let snipname = snipname.'.'.extension
    endif
    if ('y' ==? input('Create snippet "'.snipname.'"? [y/n] '))
        exec 'edit '.fnameescape(expand(g:my_snippet.'/'.snipname))
    endif
endfunction

inoremap <C-j> <Esc>:call <SID>ReadSnippet()<CR>
