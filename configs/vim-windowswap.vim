" Swap window buffers
Plug 'https://github.com/wesQ3/vim-windowswap.git'

" Prevent default bindings
let g:windowswap_map_keys = 0

" Swap windows: do once in source window, once in target window
nnoremap <Leader>wx :call WindowSwap#EasyWindowSwap()<CR>
