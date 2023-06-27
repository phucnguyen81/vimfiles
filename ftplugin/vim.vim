setlocal colorcolumn=80
setlocal foldmethod=marker foldmarker={{,}}
setlocal keywordprg=:help
setlocal suffixesadd+=.vim

" Source current vim file
nnoremap <buffer> <Leader>so :source %<CR>

" Use lookup function from 'mhinz/vim-lookup'
let b:my_goto_definition_command = 'call lookup#lookup()'

" TODO have to set a global variable here since the indent/vim.vim settings
" use this variable for indenting its comments, should find a better way
let g:vim_indent_cont = 4

function! s:VimSearchDoc(symbol) abort
    call openbrowser#search('vim '.a:symbol)
endfunction
let b:my_search_doc_function = funcref('s:VimSearchDoc')
