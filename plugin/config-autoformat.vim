" Easy code formatting by integrating existing code formatters
Plug 'https://github.com/Chiel92/vim-autoformat'

" Don't let autoformat show more messages
let g:autoformat_verbosemode=0

" Formatter for lua
let g:formatdef_lua = '"luafmt --stdin --indent-count 2"'
let g:formatters_lua = ['lua']
