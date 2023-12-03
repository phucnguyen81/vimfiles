" open-browser: launch browsers to open links, search texts,...
" See built-in search engines: plugged/open-browser.vim/autoload/vital/__openbrowser__/OpenBrowser/Config.vim

" Replace netrw's gx mapping with openbrowser
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" TODO support getting query from range
func! s:search(query)
    let query = empty(a:query) ? expand('<cWORD>') : a:query
    let search_engine = 'google'
    call openbrowser#search(query, search_engine)
endfunc

command -nargs=* Google call <SID>search(<q-args>)
