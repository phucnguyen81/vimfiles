" Read a template into current buffer.
" The template is searched for using the word under cursor and
" the current file extension.
function! s:ReadTemplate(...) abort
    if empty(a:000)
        let filename = expand('<cWORD>')
    else
        let filename = a:1
    endif
    let extension = expand('%:e')
    let template1 = findfile(filename, g:my_templates)
    let template2 = findfile(filename.'.'.extension, g:my_templates)
    let template = empty(template1) ? template2 : template1
    if filereadable(template)
        if empty(a:000)
            normal! diW
        endif
        exec '-1read '.fnameescape(template)
        return
    endif
    let templatename = filename 
    if (match(templatename, '\.') == -1) && !empty(extension)
        let templatename = templatename.'.'.extension
    endif
    if ('y' ==? input('Create template "'.templatename.'"? [y/n] '))
        exec 'edit '.fnameescape(expand(g:my_templates.'/'.templatename))
    endif
endfunction

" TODO auto-completion on template names
command! -nargs=? Template call <SID>ReadTemplate(<f-args>)
