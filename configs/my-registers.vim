" Working with registers

command! -nargs=? EditRegister :call s:edit_register('q', <f-args>)

func! s:edit_register(default, ...) abort
    let reg = a:default
    if !empty(a:000)
        let reg = a:000[0]
    endif

    " Read register into a scratch buffer
    new
    setlocal buftype=nofile
    call append(0, getreg(reg))
    call cursor(1,1)

    " Auto-save the register upon leaving buffer.
    " TODO this seems to add newlines to register, should not save
    " newlines in buffer to register.
    autocmd! BufLeave <buffer>
    exec join(['autocmd BufLeave <buffer>',
      \ ':call setreg('''.reg.''', getline(1, ''$''))',
      \ '| :bdelete!',
      \ ])

    echom 'Editing register "'.reg
endfunc
