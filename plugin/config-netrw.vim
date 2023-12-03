" Check out |netrw-browse-maps| for more mappings
" :edit <dir> to open dir in file browser
" <CR>/v/t to open in an h-split/v-split/tab
" :Ntree <dirname> to change root dir
" d : create new directory
" % : create new file
" a : switch between hidden and full views
" i : switch between list view styles: list, tree,...
"
" Don't show banner
let g:netrw_banner = 0
" Use 30 characters width for :Lexplore
let g:netrw_winsize = -30
" Start with list style, switch with 'i'.
" 3 is for tree-view, useful but too buggy.
let g:netrw_liststyle = 0
" Preview file in bottom-left window
let g:netrw_preview = 0
let g:netrw_alto = 0
let g:netrw_altv = 0
" netrw_gx defines url pattern, doing `gx` opens the url
let g:netrw_gx = "<cWORD>"
