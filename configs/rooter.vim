" Work with project root directory.
" Root directory is identified by presence of known file/directory.
Plug 'https://github.com/airblade/vim-rooter.git'

" Auto-change directory can cause problems with other plugins
let g:rooter_manual_only = 1

" Patterns that indicate a root directory.
" Patterns that come first will be searched first.
" Patterns that end with '/' are for directories.
let g:rooter_patterns = ['package.json', 'manage.py', '.git/', 'README.md']
