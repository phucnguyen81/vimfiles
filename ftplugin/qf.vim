" Reset default mapping of <CR> for quickfix window.
" Have to do this because somehow <CR> is mapped to :wincmd W.
" This is a workaround until a a cleaner fix is found.
nnoremap <CR> :.cc<CR>
