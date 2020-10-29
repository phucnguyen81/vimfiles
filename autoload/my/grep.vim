func! s:defaultparams() abort
    return {
        \ 'dir': getcwd(),
        \ 'pattern': '',
        \ 'wholeword': 0
        \ }
endfunc

func! s:defaultgrep(params) abort
    throw 'No candidates for grep function.'
endfunc

func! s:ripgrep(params) abort
    let wholeword = a:params.wholeword
    let pattern = a:params.pattern

    setlocal grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ $*
    setlocal grepformat=%f:%l:%c:%m
    " TODO: need to escape special characters for vim command
    " e.g. # in command mode will be extended to alternate path
    if wholeword
        exec 'grep! --word-regexp '.shellescape(pattern)
    else
        exec 'grep! --fixed-strings '.shellescape(pattern)
    endif
endfunc

func! my#grep#grep(params) abort
    botright copen
    redraw
    let params = s:defaultparams()
    call extend(params, a:params, 'force')
    exec 'lcd '.fnameescape(params.dir)
    call s:grep_func(params)
    redraw!
endfunc

if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ $*
    set grepformat=%f:%l:%c:%m
    let s:grep_func = function('s:ripgrep')
else
    let s:grep_func = function('s:defaultgrep')
endif
