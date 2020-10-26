" Compile/run current file (see compiler section in quickfix)
command! -nargs=0 Pmake call my#make#make(my#project#dir())
nnoremap <Leader>pm :call my#make#make(my#project#dir())<CR>

" Search for words/whole-words
command! -nargs=* -bang Pgrep call
    \ my#grep#ripgrep(my#project#dir(), <bang>0, <f-args>)
nnoremap <Leader>pg :call
    \ my#grep#ripgrep(my#project#dir(), 1, expand('<cword>'))<CR>

" Fuzzy-find files in project directory
function! s:FindFile() abort
    let dir = my#project#dir()
    let source = exists('g:my_fzf_default_command')
        \ ? g:my_fzf_default_command : ''
    call my#find#fuzzyfind(dir, source)
endfunction
command! -nargs=0 Pfind call <SID>FindFile()
nnoremap <silent> <C-p> :call <SID>FindFile()<CR>
