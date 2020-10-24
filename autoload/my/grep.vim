" Run ripgrep as grepprg.
" Args:
"   dir: the default directory to run search in
"   wholeword: whether to search for whole-word
"   ...: pattern (required) and dirs (optional) to search in
func! my#grep#ripgrep(dir, wholeword, ...) abort
    let dir = a:dir
    let wholeword = a:wholeword
    let arg = empty(a:000) ? expand('<cword>') : join(a:000)

    botright copen
    redraw!
    exec 'lcd '.fnameescape(dir)
    setlocal grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ $*
    setlocal grepformat=%f:%l:%c:%m

    if wholeword
        exec 'grep --word-regexp '.arg
    else
        exec 'grep --fixed-strings '.arg
    endif
endfunc
