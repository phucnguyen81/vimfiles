" Project tree
func! s:ProjectTree() abort
    let current_file = expand('%:p')
    exec 'NERDTree '.fnameescape(my#project#dir())
    if !empty(glob(current_file, 1))
        exec 'NERDTreeFind '.fnameescape(current_file)
    endif
endfunc
nnoremap <Leader>pt :call <SID>ProjectTree()<CR>

" Compile/run current file (see compiler section in quickfix)
command! -nargs=0 Pmake call my#make#make(my#project#dir())
nnoremap <Leader>pm :call my#make#make(my#project#dir())<CR>

" Search for words/whole-words
func! s:Grep(wholeword, ...) abort
    let pattern = empty(a:000)? expand('<cword>'): a:000[0]
    call my#grep#grep(#{
        \ dir: my#project#dir(),
        \ wholeword: a:wholeword,
        \ pattern: pattern
        \})
endfunc
command! -nargs=? -bang Pgrep call <SID>Grep(<bang>0, <f-args>)
nnoremap <Leader>pg :call <SID>Grep(1)<CR>

" Fuzzy-find files in project directory
func! s:FindFile() abort
    let dir = my#project#dir()
    let source = exists('g:my_fzf_default_command')
        \ ? g:my_fzf_default_command : ''
    call my#find#fuzzyfind(dir, source)
endfunc
command! -nargs=0 Pfind call <SID>FindFile()
nnoremap <silent> <C-p> :call <SID>FindFile()<CR>
