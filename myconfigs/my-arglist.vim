" Add current file to arglist
nnoremap <Leader>aa :<C-u>argadd<CR>:args<CR>

" Work with arglist
command! Args call my#arglist#edit()
nnoremap <Leader>as :<C-u>call my#arglist#edit()<CR>
