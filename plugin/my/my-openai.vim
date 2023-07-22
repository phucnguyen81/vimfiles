" Mappings to trigger completion
nnoremap <leader>oc :<C-u>call myfun#openai_complete()<CR>
xnoremap <leader>oc :<C-u>call myfun#openai_complete()<CR>

" Command to trigger completion
command! -nargs=0 OpenAIComplete call myfun#openai_complete()<CR>
