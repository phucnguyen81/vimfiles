" TODO: checkout `lf --help`, write selected files to file and
" open the file on terminal exit

func! my#lf#lf() abort
    exec 'term ++noclose ++curwin lf'
endfunc
