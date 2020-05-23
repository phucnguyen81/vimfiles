" Auto-expand selection:
" hit v to select one character
" hit v again to select current word
" hit v again to select paragraph
" ...
" hit <C-v> to shrink the selection if went too far
Plug 'https://github.com/terryma/vim-expand-region.git'

vmap v <plug>(expand_region_expand)
vmap <C-v> <plug>(expand_region_shrink)
