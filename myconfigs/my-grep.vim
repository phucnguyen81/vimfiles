command! -nargs=* -bang Grep call myvim#ripgrep(getcwd(), <bang>0, <f-args>)
