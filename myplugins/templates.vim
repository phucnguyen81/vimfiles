" Open templates directory
function! s:TemplatesDir() abort
    -tabnew
    exec 'lcd '.fnameescape(g:my_templates)
    edit .
endfunction

" Fuzzy select a template file to read into current buffer
function! s:ReadTemplate() abort
    call fzf#run({'dir': g:my_templates, 'sink': 'read'})
endfunction

" Mapping for reading a template file
nnoremap <Leader>rt :<C-u>call <SID>ReadTemplate()<CR>

" Open directory containing templates
command! -nargs=0 Tpl call <SID>TemplatesDir()

" Read template
command! -nargs=0 Tplread call <SID>ReadTemplate()
