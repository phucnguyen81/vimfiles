" Configure SnipMate
" Use the new parser, see :SnipMate-parser-versions
" Usage: for example in a python file type `for<tab>` to trigger snippets

let g:snipMate = { 'snippet_version' : 1 }
nnoremap <Leader>sm :SnipMateOpenSnippetFiles<CR>

" Change trigger:
" imap <C-j> <Plug>snipMateNextOrTrigger
