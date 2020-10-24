Plug 'https://github.com/pechorin/any-jump.vim.git'

" Auto search references
let g:any_jump_references_enabled = 1

" Prefered search engine: rg or ag
let g:any_jump_search_prefered_engine = 'rg'

" Disable default any-jump keybindings (default: 0)
let g:any_jump_disable_default_keybindings = 1

" Custom ignore files
" default is: ['*.tmp', '*.temp']
let g:any_jump_ignored_files = [
    \ '*.tmp', '*.temp', '*.bak', '*.swp']

nnoremap <Leader>aj :AnyJump<CR>
