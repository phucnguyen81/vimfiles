func! my#find#fuzzyfind(dir, source) abort
    let configs = {
        \ 'dir': a:dir,
        \ 'options': [
            \ '--multi', '--reverse',
            \ '--bind=change:top,ctrl-g:cancel,ctrl-d:page-down,ctrl-u:page-up',
            \ ],
        \ 'sink': 'edit',
        \ 'down': '50%'
        \ }
    if !empty(a:source)
        let configs.source = a:source
    endif
    call fzf#run(configs)
endfunc
