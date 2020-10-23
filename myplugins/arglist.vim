" Add current file to arglist
nnoremap <Leader>aa :<C-u>argadd<CR>:args<CR>

" Work with arglist
command! Args call myarglist#Arglist()
nnoremap <Leader>as :<C-u>call myarglist#Arglist()<CR>
