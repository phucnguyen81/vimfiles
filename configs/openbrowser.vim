Plug 'https://github.com/tyru/open-browser.vim'

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" TODO support getting query from range
function! s:search(query)
    let query = empty(a:query) ? expand('<cword>') : a:query
    let search_engine = 'google'
    call openbrowser#search(query, search_engine)
endfunction

command -nargs=* Google :call <SID>search(<q-args>)
