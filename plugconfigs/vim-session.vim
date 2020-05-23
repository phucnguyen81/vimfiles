" Manage sessions
Plug 'https://github.com/xolox/vim-session.git'

if exists('g:my_session_dir')
    " Global directory for session files
    let g:session_directory = g:my_session_dir
endif

" Turn off some default configs
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:session_persist_font = 0
let g:session_persist_colors = 0

" Make command aliases such as SessionOpen, SessionDelete, ect.
let g:session_command_aliases = 1

