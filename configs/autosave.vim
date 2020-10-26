" Automatically save changes to disk
Plug 'https://github.com/907th/vim-auto-save.git'

if exists('g:my_auto_save_on')
    let g:auto_save = g:my_auto_save_on
endif

" Events such as InsertLeave and TextChanged have performance problems when
" macros are executed. `CursorHold` is only triggered if the user is not
" typing for a while and is not re-triggered until the user starts typing
" again.
let g:auto_save_events = ["CursorHold"]
if &updatetime < 500
    echoerr '&updatetime ' &updatetime 'is too small, might cause problems'
endif

" Write only current buffer, do not write all buffers
let g:auto_save_write_all_buffers = 0 

" Disable autosave in diff mode.
augroup my_autosave_disable
    autocmd!
    autocmd BufEnter * if &diff | let b:auto_save = 0 | endif
augroup end
