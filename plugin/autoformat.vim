" autoformat plugin configs
" See: https://github.com/Chiel92/vim-autoformat
" :help autoformat

" Whether to let autoformat show more messages
let g:autoformat_verbosemode=0

" Define formatter for lua code
let g:formatdef_lua = '"luafmt --stdin --indent-count 2"'
let g:formatters_lua = ['lua']
