"""Override settings that were set in some plugins

" Override vim-sensible
set scrolloff=8

" Override vim-vinegar
let g:netrw_list_hide = join([
  \ '__pycache__', '\.pyc',
  \ '\.DAT$', '\.dat$', '^ntuser',
  \ ], ',')
