" Automatically save changes to disk.
" Source: https://github.com/907th/vim-auto-save
"
" Default config will save after InsertLeave and TextChanged events.
" InsertLeave: leave INSERT mode.
" TextChanged: texts changed in NORMAL mode (very often).

" Set autosave by global option
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

" Toggle autosave for current buffer
command AutoSaveToggleLocal :call s:AutoSaveToggleLocal()
function s:AutoSaveToggleLocal()
    if !exists('b:auto_save')
        let b:auto_save = 1
    endif
    let b:auto_save = !b:auto_save
endfunction

" Disable autosave in diff mode.
augroup autosave_disable
    autocmd!
    autocmd BufEnter * if &diff | let b:auto_save = 0 | endif
augroup end
