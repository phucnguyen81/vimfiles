" Set up grep functions.
" TODO consider FlyGrep or Rg for alternatives

if executable('rg')
    let &grepprg = 'rg --no-heading --vimgrep --smart-case $*'
    set grepformat=%f:%l:%c:%m

    function! s:grep(wholeword, ...)
        let wholeword = a:wholeword
        let arg = empty(a:000) ? expand('<cword>') : join(a:000)
        split
        exec 'lcd '.fnameescape(myfun#current_dir())
        if wholeword
            exec 'grep --word-regexp '.arg
        else
            exec 'grep --fixed-strings '.arg
        endif
    endfunction

    command! -nargs=* -bang Grep call s:grep(<bang>0, <f-args>)
endif
