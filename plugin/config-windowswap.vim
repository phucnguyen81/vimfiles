" windowswap: swaps window buffers
" Source: https://github.com/wesQ3/vim-windowswap.git

" Prevent default bindings
let g:windowswap_map_keys = 0

" Swap windows: mark source window, then mark target window to swap
nnoremap <Leader>wx :call WindowSwap#EasyWindowSwap()<CR>
