" Run make
command! -nargs=0 Pmake call my#make#make(my#project#dir())
nnoremap <Leader>pm :call my#make#make(my#project#dir())<CR>

" Run grep
command! -nargs=* -bang Pgrep call my#grep#ripgrep(
    \ my#project#dir(), <bang>0, <f-args>)
