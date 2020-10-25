" Automatically save changes to disk
Plug 'https://github.com/907th/vim-auto-save'

if exists('g:my_auto_save_enable')
    let g:auto_save = g:my_auto_save_enable
endif

" Events such as InsertLeave and TextChanged have performance problems when
" macros are executed. `CursorHold` is only triggered if the user is not
" typing for a while and is not re-triggered until the user starts typing
" again.
let g:auto_save_events = ["CursorHold"]
if &updatetime < 500
    echoerr '&updatetime ' &updatetime 'is too small, might cause problems'
endif

" Alias
command ToggleAutoSave :AutoSaveToggle

" Disable autosave in diff mode.
augroup my_autosave_disable
    autocmd!
    autocmd BufEnter * if &diff | let b:auto_save = 0 | endif
augroup end
