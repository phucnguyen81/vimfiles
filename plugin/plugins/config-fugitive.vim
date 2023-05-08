" fugitive: git integration
" Source: https://github.com/tpope/vim-fugitive.git

" Git status
nnoremap <Leader>gs :0Git<CR>

" Sync changes with remote
command! -nargs=0 Gsync call my#git#sync()

" Stage current file
command! -nargs=0 Gadd Git add %
