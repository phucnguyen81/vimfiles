" Fuzzy select a template file to read into current buffer
function! s:ReadTemplate() abort
    call fzf#run({'dir': g:my_templates, 'sink': 'read'})
endfunction

" Mapping for reading a template file
nnoremap <Leader>rt :<C-u>call <SID>ReadTemplate()<CR>

" Open directory containing templates
command! -nargs=0 Tpl exec 'edit '.fnameescape(g:my_templates)

" Read template
command! -nargs=0 TplRead call <SID>ReadTemplate()
