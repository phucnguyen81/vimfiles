func! mygrep#ripgrep(dir, wholeword, ...) abort
    let dir = a:dir
    let wholeword = a:wholeword
    let arg = empty(a:000) ? expand('<cword>') : join(a:000)

    botright copen
    redraw
    exec 'lcd '.fnameescape(dir)
    setlocal grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ $*
    setlocal grepformat=%f:%l:%c:%m
    if wholeword
        exec 'grep --word-regexp '.arg
    else
        exec 'grep --fixed-strings '.arg
    endif
endfunc
