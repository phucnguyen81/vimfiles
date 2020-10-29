" Status line
Plug 'https://github.com/itchyny/lightline.vim.git'

func! CurrentDirName() abort
    return fnamemodify(getcwd(), ':t')
endfunc

" See lightline
let g:lightline = {
    \ 'colorscheme': 'PaperColor',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \           [ 'cwdname' ],
    \           [ 'readonly', 'relativepath', 'modified' ] ],
    \    'right': [ [ 'lineinfo' ],
    \             [ 'percent' ],
    \             [ 'fileformat', 'fileencoding', 'filetype' ] ],
    \ },
    \ 'inactive': {
    \   'left': [ [ 'relativepath' ] ],
    \   'right': [ [ 'lineinfo' ] ],
    \ },
    \ 'tabline': {
    \   'right': []
    \ },
    \ 'tab_component': {
    \   'at': '@'
    \ },
    \ 'tab': {
    \   'active': [ 'tabnum', 'filename', 'modified' ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead',
    \   'cwdname': 'CurrentDirName',
    \ },
    \ }
