" Start-screen for recent files, bookmarks, sessions,...
Plug 'https://github.com/mhinz/vim-startify.git'

if exists('g:my_session_dir') && isdirectory(g:my_session_dir)
    let g:startify_session_dir = g:my_session_dir
endif

" What to show on Startify screen.
let g:startify_lists = [
  \ { 'type': 'commands',  'header': ['   Commands'] },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'dir',       'header': ['   Recently opened'] },
  \ ]

let g:startify_commands = [
  \ {'<C-d>': [' Doing', 'Doing']},
  \ {'<C-f>': [' Fuzzy Search', 'NN']},
  \ {'<C-s>': [' Sessions', 'Sessions']},
  \ {'<C-t>': [' Templates', 'Tpl']},
  \ ]

let g:startify_disable_at_vimenter = 0
let g:startify_use_env = 1
let g:startify_enable_special = 0
let g:startify_custom_header = []
let g:startify_update_oldfiles = 1
let g:startify_change_to_dir = 0
let g:startify_files_number = 10
let g:startify_session_dir = g:my_session_dir
let g:startify_session_sort = 1
let g:startify_session_autoload = 0
let g:startify_session_persistence = 0

nnoremap <Leader><Leader> :Startify<CR>
nnoremap <Leader>st :Startify<CR>
