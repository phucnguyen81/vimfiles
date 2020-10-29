func! s:vifm(option) abort
    let option = a:option
    let curfile = myfun#current_file()
    let left = empty(curfile)? '.': '--select '.shellescape(curfile)
    exec 'term ++noclose ++curwin vifm '.option.' '.left.' .'
endfunc

func! my#vifm#select() abort
    call s:vifm('')
endfunc

func! my#vifm#choosefiles() abort
    call s:vifm('--choose-files -')
endfunc
