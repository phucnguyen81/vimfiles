" startify: vim dashboard

" What to show on Startify screen
let g:startify_lists = [
  \ { 'type': 'commands',  'header': ['   Files'] },
  \ { 'type': 'sessions',  'header': ['   Sessions'] },
  \ { 'type': 'files',     'header': ['   Recent'] },
  \ ]

let g:startify_commands = [
    \ {'<C-o>': [' Open', 'browse edit']},
    \ {'<C-n>': [' New', 'enew']},
    \ {'<C-e>': [' Explorer', 'Explore']}
  \ ]

let g:startify_disable_at_vimenter = 0
let g:startify_use_env = 1
let g:startify_enable_special = 0
let g:startify_custom_header = []
let g:startify_update_oldfiles = 1
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_files_number = 7
let g:startify_session_number = 3
let g:startify_session_sort = 1
let g:startify_session_autoload = 0
let g:startify_session_persistence = 1

nnoremap <Leader><Leader> :Startify<CR>
nnoremap <Leader>st :Startify<CR>

" Save session before exit
augroup my_save_session
    autocmd!
    autocmd VimLeave * call <SID>SaveSession()
augroup end

" Save a session using basename of current working directory
function! s:SaveSession() abort
    if exists(':SSave') ==# 2
        let dirname = fnamemodify(getcwd(), ':t')
        exec 'SSave! '.dirname
    endif
endfunction
