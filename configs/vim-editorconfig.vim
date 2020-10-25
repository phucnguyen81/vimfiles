" Apply editorconfig file (indent, end-of-line, trailing-spaces, etc)
" NOTE: if possible, should use the offical support https://github.com/editorconfig/editorconfig-vim
Plug 'https://github.com/sgur/vim-editorconfig.git'

" Cases excluded from editorconfig
let g:editorconfig_blacklist = {
    \ 'filetype': ['git.*', 'fugitive'],
    \ 'pattern': ['\.un~$']}

