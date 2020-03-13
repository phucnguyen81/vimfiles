" Configs for xolox/vim-session plugin.
" Source: https://github.com/xolox/vim-session
" Help: session.txt

" Where to save session files
if exists('g:my_session_dir')
    let g:session_directory = g:my_session_dir
endif

" Turn off some default configs
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:session_persist_font = 0
let g:session_persist_colors = 0

" Make command aliases such as SessionOpen, SessionDelete, ect.
let g:session_command_aliases = 1

