" Show all templates
func! s:TemplatesDir() abort
    if exists('g:my_templates') && isdirectory(g:my_templates)
        exec 'edit '.fnameescape(g:my_templates)
    else
        throw '`g:my_templates` must be a directory'
    endif
endfunc
command! -nargs=0 Tpl call <SID>TemplatesDir()

" Select a template to read into current buffer
func! s:ReadTemplate() abort
    call fzf#run({'dir': g:my_templates, 'sink': 'read'})
endfunc
command! -nargs=0 Tplread call <SID>ReadTemplate()
nnoremap <Leader>rt :<C-u>call <SID>ReadTemplate()<CR>
