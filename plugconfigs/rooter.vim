" Changes Vim working directory to project root
" (identified by presence of known directory or file).
Plug 'https://github.com/airblade/vim-rooter.git'

" Auto-change directory can cause problems with other plugins
let g:rooter_manual_only = 1

" Patterns that indicate a root directory.
" Patterns that come first will be searched first to determine
" the root directory.
let g:rooter_patterns = ['package.json', 'manage.py', '.git']
