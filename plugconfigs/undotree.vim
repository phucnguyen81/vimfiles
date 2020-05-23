" Shows tree structure of undo history
Plug 'https://github.com/mbbill/undotree.git'

" Focus after open
let g:undotree_SetFocusWhenToggle = 1

" Set width
let g:undotree_SplitWidth = 30

" Toggle graphical view of undo tree
command! UndoTree :UndotreeToggle
