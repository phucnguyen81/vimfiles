" Sometimes go right one character is all I need
inoremap <C-l> <right>

" Do <c-u> but allow undoing its changes
inoremap <C-u> <C-g>u<C-u>

" <CR> always accepts completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" If popup is visible, close it; else exit insert mode.
inoremap <expr> jk pumvisible() ? "<C-e>" : "<Esc>"

