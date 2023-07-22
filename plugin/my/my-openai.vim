" Mappings to trigger completion
nnoremap <leader>oc :<C-u>call myfun#openai_complete()<CR>
xnoremap <leader>oc :<C-u>call myfun#openai_complete()<CR>

" Command to trigger completion
command! -bang -nargs=* -range Gpt call myfun#openai_complete(<q-args>, <line1>, <line2>,<bang>0)<CR>
