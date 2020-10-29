" Need to set netrw_list_hide here since it is set in vim-vinegar
let g:netrw_list_hide = join([
  \ '__pycache__', '\.pyc',
  \ '\.DAT$', '\.dat$', '^ntuser',
  \ ], ',')
