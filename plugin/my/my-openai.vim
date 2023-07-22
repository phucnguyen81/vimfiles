" Mappings to trigger completion
nnoremap <leader>oc :<C-u>call myfun#openai_complete()<CR>
xnoremap <leader>oc :<C-u>call myfun#openai_complete()<CR>

" Command to trigger completion
command! -nargs=? Gpt call myfun#openai_complete(<q-args>)<CR>
