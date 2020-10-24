command! -nargs=* -bang Grep call my#grep#ripgrep(getcwd(), <bang>0, <f-args>)
