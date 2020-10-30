let s:my_notes = ''
if exists('g:my_notes_dir') && isdirectory(g:my_notes_dir)
    let s:my_notes = g:my_notes_dir
endif

func! s:Notes(...) abort
    if !isdirectory(s:my_notes)
        throw 'Notes directory not found.'
    endif
    let note = empty(a:000)? '': a:000[0]
    if empty(note)
        exec 'edit '.fnameescape(s:my_notes)
    else
        let note_file = expand(s:my_notes.'/'.note)
        exec 'edit '.fnameescape(note_file)
    endif
endfunc

command! -nargs=? Notes call s:Notes(<f-args>)
nnoremap <Leader>no :<C-u>call <SID>Notes()<CR>

" Search for tags in notes with a customized 'tagfunc'
augroup my_notes_augroup
    autocmd!
    autocmd FileType markdown,text setlocal tagfunc=my#note#tagfunc
augroup end
