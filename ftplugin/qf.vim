" `qf` filetype applies to both quickfix and location list buffers

" close quickfix window
nnoremap <buffer> q :close<CR>

" preview current quickfix entry
nnoremap <buffer> p :PreviewQuickfix<CR>
nnoremap <buffer> P :PreviewClose<CR>

" scroll preview window
noremap <m-u> :PreviewScroll -1<cr>
noremap <m-d> :PreviewScroll +1<cr>
inoremap <m-u> <c-\><c-o>:PreviewScroll -1<cr>
inoremap <m-d> <c-\><c-o>:PreviewScroll +1<cr>
