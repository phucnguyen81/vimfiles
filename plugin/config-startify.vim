" startify: vim dashboard

" What to show on Startify screen
let g:startify_lists = [
  \ { 'type': 'commands',  'header': ['   Commands'] },
  \ { 'type': 'files',     'header': ['   Recent'] },
  \ ]

let g:startify_commands = [
    \ {'J': [' Journal', 'Journal']},
    \ {'h': [' Recent files', 'History']},
    \ {'m': [' Bookmarks', 'Bookmarks']},
    \ {'n': [' Notes', 'Note']},
    \ {'o': [' Open', 'browse edit']},
    \ {'q': [' Quit', 'qa']},
    \ {'s': [' Sessions', 'Sessions']},
    \ {'t': [' Today', 'Today']},
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
let g:startify_session_persistence = 0
if exists('g:my_session_dir')
    let g:startify_session_dir = g:my_session_dir
    command! -nargs=0 Sessions exec 'edit '.fnameescape(g:startify_session_dir)
endif

nnoremap <Leader><Leader> :Startify<CR>
nnoremap <Leader>st :Startify<CR>
nnoremap <Leader>ss :SSave!<CR>

" Save session before exit
augroup my_save_session
    autocmd!
    autocmd VimLeave * call <SID>SaveSession()
augroup end

" Save latest session
function! s:SaveSession() abort
    if exists(':SSave') ==# 2
        SSave! lastest
    endif
endfunction

