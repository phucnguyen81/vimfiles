" Run make (use compiler settings)
command! -nargs=0 Pmake call my#make#make(my#project#dir())
nnoremap <Leader>pm :call my#make#make(my#project#dir())<CR>

" Grep for words/whole-words
command! -nargs=* -bang Pgrep call my#grep#ripgrep(
    \ my#project#dir(), <bang>0, <f-args>)

" Fuzzy-find files in project directory
function! s:FindFile() abort
    let dir = my#project#dir()
    let source = exists('g:my_fzf_default_command')
        \ ? g:my_fzf_default_command : ''
    call my#find#fuzzyfind(dir, source)
endfunction
command! -nargs=0 Pfind call <SID>FindFile()
nnoremap <silent> <C-p> :<C-u>call <SID>FindFile()<CR>
