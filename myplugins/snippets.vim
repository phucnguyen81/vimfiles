" Read snippet from 'snippets' directory
function s:ReadSnippet() abort
    " Read the word before/at the cursor
    let curword = expand('<cword>')
    let extension = expand('%:e')
    if empty(curword) || empty(extension)
        return
    endif
    let filename = empty(extension) ? curword : (curword.'.'.extension)
    let snippet = expand(g:my_snippets.'/'.filename)
    normal! diw
    exec '-1read '.fnameescape(snippet)
endfunction

inoremap <C-j> <Esc>:call <SID>ReadSnippet()<CR>
