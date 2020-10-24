" Run make
command! -nargs=0 Pmake call myproject#make()
nnoremap <Leader>pm :call myproject#make()<CR>

" Run grep
command! -nargs=* -bang Pgrep call myvim#ripgrep(
    \ myproject#project_dir(), <bang>0, <f-args>)
