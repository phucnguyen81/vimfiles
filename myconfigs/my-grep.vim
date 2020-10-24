" Set up muliptle choices for grep commands

command! -nargs=* -bang Rgrep call mygrep#ripgrep(getcwd(), <bang>0, <f-args>)
