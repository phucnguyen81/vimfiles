if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ $*
    set grepformat=%f:%l:%c:%m
    let g:MyGrepFunc = function('my#grep#ripgrep')
else
    let g:MyGrepFunc = function('my#grep#defaultgrep')
endif

func! s:Grep(wholeword, ...) abort
    let pattern = empty(a:000)? expand('<cword>'): a:000[0]
    let results = g:MyGrepFunc({
        \ 'dir': getcwd(),
        \ 'wholeword': a:wholeword,
        \ 'pattern': pattern
        \})
    call setqflist(results['items'])
endfunc
command! -nargs=? -bang Grep call <SID>Grep(<bang>0, <f-args>)
nnoremap <Leader>gw :<C-u>call <SID>Grep(1)<CR>

