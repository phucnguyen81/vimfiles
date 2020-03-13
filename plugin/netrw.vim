" Check out |netrw-browse-maps| for more mappings
"
" :edit <dir> to open file browser
" <CR>/v/t to open in an h-split/v-split/tab
" :Ntree <dirname> to change root dir
" d : create new directory
" % : create new file
" a : switch between hidden and full views

if exists('g:my_netrw_home')
    let g:netrw_home = g:my_netrw_home
endif

" Don't show banner
let g:netrw_banner = 0

" Start with list style, switch with 'i'.
" 3 is for tree-view, useful but too buggy.
let g:netrw_liststyle = 0

" Preview file in bottom-left window
let g:netrw_preview = 0
let g:netrw_alto = 0
let g:netrw_altv = 0

" Open the file explorer to the left with initial width set to 30
nnoremap <Leader>le :30Lexplore<Space><C-r>=fnameescape(myfun#current_dir())<CR><CR>
