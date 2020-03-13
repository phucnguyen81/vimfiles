" Enhanced movements
" See: https:/github.com/easymotion/vim-easymotion

if !exists('g:EasyMotion_loaded')
    finish
endif

" Navigtate downwards
nmap s <Plug>(easymotion-f2)

" Navigtate upwards
nmap S <Plug>(easymotion-F2)

" Move to line below
map <C-j> <Plug>(easymotion-j)

" Move to line above
map <C-k> <Plug>(easymotion-k)
