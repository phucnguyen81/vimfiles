" Status line
Plug 'https://github.com/itchyny/lightline.vim.git'

" Replace filename with relative-path
let g:lightline = {
    \ 'colorscheme': 'PaperColor',
    \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'relativepath', 'modified' ] ],
    \ },
    \ 'inactive': {
        \ 'left': [ [ 'relativepath' ] ]
    \ }
\ }
