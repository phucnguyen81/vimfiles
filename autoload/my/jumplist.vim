" TODO: make this more robust by checking with getjumplist():
" - stop before jumping to non-existing buffer

" Jump to previous buffer in the jumplist
func! my#jumplist#jumpout() abort
    let save_bufnr = bufnr('%')
    let jumplist = getjumplist()
    let jumps = jumplist[0]
    let lastjump = jumplist[1]

    let i = lastjump
    while i > 0
        exe "normal! \<C-o>"
        if bufnr('%') != save_bufnr
            return
        endif
        let i = i - 1
    endwhile
    echom 'Hit start of jumplist.'
endfunc

" Jump to next buffer in the jumplist
func! my#jumplist#jumpin() abort
    let save_bufnr = bufnr('%')
    let jumplist = getjumplist()
    let jumps = jumplist[0]
    let lastjump = jumplist[1]
    let maxjumps = len(jumps)

    let j = lastjump
    while j < maxjumps
        " Have to use `1<C-i>` because `<C-i>` and `<TAB>` have the
        " same keycode; without `1`, `<C-i>` is treated as whitespaces
        " that come after the `normal!` command.
        exe "normal! 1\<C-i>"
        if bufnr('%') != save_bufnr
            return
        endif
        let j = j + 1
    endwhile
    echom 'Hit end of jumplist.'
endfunc
