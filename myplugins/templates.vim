" Read a template into current buffer.
" The template is searched for using the word under cursor and
" the current file extension.
function! s:ReadTemplate(...) abort
    if empty(a:000)
        exec 'Explore '.fnameescape(g:my_templates)
        return
    endif

    let filename = a:1
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

function! s:ReplaceWordWithTemplate()
    let word = expand("<cWORD>")
    normal! diW
    call s:ReadTemplate(word)
endfunction

" On new file, read template file into buffer
function s:OnBufNewFile() abort
    let extension = expand('%:e')
    if !empty(extension)
        let template = expand(g:my_templates.'/template.'.extension)
        if filereadable(template)
            exec '-1read '.fnameescape(template)
        endif
    endif
endfunction

augroup my_template_autocmd
    autocmd!
    autocmd BufNewFile * call <SID>OnBufNewFile()
augroup end

" TODO auto-completion of template name
command! -nargs=? Template call <SID>ReadTemplate(<f-args>)

inoremap <C-j> <Esc>:<C-u>call <SID>ReplaceWordWithTemplate()<CR>
