" Project tree
func! s:ProjectTree() abort
    let current_file = expand('%:p')
    exec 'NERDTree '.fnameescape(my#project#dir())
    if !empty(glob(current_file, 1))
        exec 'NERDTreeFind '.fnameescape(current_file)
    endif
endfunc
nnoremap <Leader>pt :call <SID>ProjectTree()<CR>

" Run current file
func! s:Run() abort
    let filetype = &filetype
    if empty(filetype)
        throw 'Filetype not set.'
    endif
    let runner = filetype.'-run'
    if empty(findfile('compiler/'.runner.'.vim', &rtp))
        throw 'Compiler '.runner.' not found.'
    endif
    call my#make#make(runner, my#project#dir())
    botright copen
    redraw! "skip console messages
endfunc
command! -nargs=0 Prun call s:Run()
nnoremap <Leader>pr :call <SID>Run()<CR>

" Lint/check current file
func! s:Lint() abort
    let linters = []
    if exists('b:linters') && !empty(b:linters)
        for linter in b:linters
            let compiler = findfile('compiler/'.linter.'.vim', &rtp)
            if executable(linter) && !empty(compiler)
                call add(linters, linter)
            endif
        endfor
    endif

    call my#linter#lmake(linters, my#project#dir())
    botright lopen
    redraw! "skip console messages
endfunc
command! -nargs=0 Plint call s:Lint()
nnoremap <Leader>pl :call <SID>Lint()<CR>

" Search for words/whole-words
func! s:Grep(wholeword, ...) abort
    let pattern = empty(a:000)? expand('<cword>'): a:000[0]
    call my#grep#grep({
        \ 'dir': my#project#dir(),
        \ 'wholeword': a:wholeword,
        \ 'pattern': pattern
        \})
endfunc
command! -nargs=? -bang Pgrep call <SID>Grep(<bang>0, <f-args>)
nnoremap <Leader>pg :call <SID>Grep(1)<CR>

" Fuzzy-find files in project directory
func! s:FindFile() abort
    let dir = my#project#dir()
    let source = exists('g:my_fzf_default_command')
        \ ? g:my_fzf_default_command : ''
    call my#find#fuzzyfind(dir, source)
endfunc
command! -nargs=0 Pfind call <SID>FindFile()
nnoremap <silent> <C-p> :call <SID>FindFile()<CR>
