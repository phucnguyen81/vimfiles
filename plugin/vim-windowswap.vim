" Swap windows with vim-windowswap plugin
" See: https://github.com/wesQ3/vim-windowswap

" Prevent default bindings
let g:windowswap_map_keys = 0

" wx: window exchange
nnoremap <silent> <leader>wx :call WindowSwap#EasyWindowSwap()<CR>

function s:SwapWindowAfter(cmd)
    call WindowSwap#MarkWindowSwap()
    exec a:cmd
    call WindowSwap#DoWindowSwap()
endfunction
nnoremap <silent> <Leader>wr :call <SID>SwapWindowAfter('wincmd w')<CR>
nnoremap <silent> <Leader>wR :call <SID>SwapWindowAfter('wincmd W')<CR>

