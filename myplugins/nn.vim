" TODO prepare to open source nn.vim
" (configurations, doc files, see tpope's and fzf plugins)

" TODO ctrl-x opens embedded urls
" (with python or openbrowser ? => provide default and add configuration)

command -nargs=* NN call s:nn_here(<f-args>)
nnoremap <silent> <Leader>nn :<C-u>call <SID>nn_here()<CR>

" Parent folder of this script (not account for symbolic links)
let s:script_dir = expand('<sfile>:p:h')
let s:nn_preview = ''
if isdirectory(s:script_dir)
    let s:nn_preview = findfile('nn_preview.py', s:script_dir)
endif
if filereadable(s:nn_preview)
    let s:nn_preview = fnamemodify(s:nn_preview, ':p')
endif

" Python executable
if executable('python3')
    let s:python = 'python3'
elseif executable('python')
    let s:python = 'python'
else
    let s:python = ''
endif

let s:bind_options = [
    \ 'esc:cancel', 'ctrl-g:cancel',
    \ 'change:top', 'ctrl-t:top',
    \ 'ctrl-u:page-up', 'ctrl-d:page-down',
    \ 'ctrl-p:toggle-preview',
    \ 'ctrl-s:jump',
    \ 'ctrl-y:backward-kill-word',
    \ ]

" Start search/create files in current/specified directory
function! s:nn_here(...) abort
    let arg = a:000
    if empty(arg)
        let dir = myfun#project_dir()
        let hint = ''
    else
        let dir = arg[0]
        let hint = join(arg[1:])
    endif
    call s:nn_start(dir, hint)
endfunction

" Core funtion to search/create notes in specified directory
function! s:nn_start(dir, hint) abort
    let dir = a:dir
    let hint = a:hint

    " Wrap options to use extended options of fzf such as preview
    let wrapped_options = fzf#wrap({
                \ 'dir': dir,
                \ 'source': s:fzf_source(),
                \ 'sink*': funcref('s:handle_items'),
                \ 'options': s:fzf_options(hint),
                \ }, 1)

    " Call fzf to perform fuzzy-search and handle selected items
    call fzf#run(wrapped_options)
endfunction

" Generate lines in the format `filename:lineno:line` such as
" `notes.md:2:this is a note`
function! s:fzf_source() abort
    return join(['rg',
        \ '--follow --smart-case',
        \ '--line-number', '--color never',
        \ '--no-messages --no-heading --with-filename',
        \ shellescape('\S'),
        \ ])
endfunction

function! s:fzf_options(hint) abort
    let hint = a:hint

    let fzf_options = [
        \ '--multi',
        \ '--print-query',
        \ '--expect=ctrl-n,ctrl-r,ctrl-e',
        \ '--inline-info',
        \ '--delimiter', ':',
        \ '--tiebreak=begin',
        \ '--layout', 'reverse' ,
        \ '--bind', join(s:bind_options, ',')
        \ ]

    if filereadable(s:nn_preview) && !empty(s:python)
        let preview_cmd = join([s:python, s:nn_preview, '{2} {1}'])
        call extend(fzf_options, ['--preview', preview_cmd])
        call extend(fzf_options, ['--preview-window', 'right'])
    endif

    call extend(fzf_options, ['--query', hint])

    return fzf_options
endfunction

" Callback function to handle selected items.
" `items` often looks like ['note', 'ctrl-n', 'notes.md:2:this is a note']
function! s:handle_items(items) abort
    if empty(a:items)
        return
    endif
    if len(a:items) < 2
        throw 'Expect at least query and keypress, got '.join(a:items)
    endif

    let [query, keypress; entries] = a:items

    let selections = []
    for entry in entries
        let entry_parts = extend(split(entry, ':'), ['', '', ''])
        let [path, lineno, line; rest] = entry_parts
        let path = fnamemodify(path, ':p')
        let selection = {'path': path, 'lineno': lineno, 'line': line}
        call add(selections, selection)
    endfor

    call s:handle_edit(query, keypress, selections)
    call s:handle_new(query, keypress, selections)
    call s:handle_read(query, keypress, selections)
    call s:handle_selections(query, keypress, selections)
    call s:handle_query(query, keypress, selections)
endfunction

" Edit selected files at their selected lines
function! s:handle_edit(query, keypress, selections) abort
    let [query, keypress, selections] = [a:query, a:keypress, a:selections]
    if keypress ==? 'ctrl-e' && !empty(selections)
        for selection in selections
            let [path, lineno] = [selection.path, selection.lineno]
            exec 'edit +'.lineno.' '.fnameescape(path)
        endfor
    endif
endfunction

" Read files into current buffer.
" Read from selected line up to the first blank line.
function! s:handle_read(query, keypress, selections) abort
    let [query, keypress, selections] = [a:query, a:keypress, a:selections]
    if keypress ==? 'ctrl-r' && !empty(selections)
        for selection in selections
            let lineno = max([0, selection.lineno - 1])
            let lines = s:read_file(selection.path, lineno)
            call append(line('.'), lines)
        endfor
    endif
endfunction

function! s:handle_new(query, keypress, selections) abort
    let [query, keypress, selections] = [a:query, a:keypress, a:selections]
    if !empty(query) && keypress ==? 'ctrl-n'
        call s:new_file(a:query)
    endif
endfunction

function! s:handle_query(query, keypress, selections) abort
    let [query, keypress, selections] = [a:query, a:keypress, a:selections]
    if !empty(query) && empty(keypress) && empty(selections)
        call s:new_file(a:query)
    endif
endfunction

function! s:handle_selections(query, keypress, selections) abort
    let [query, keypress, selections] = [a:query, a:keypress, a:selections]
    if empty(keypress) && !empty(selections)
        for selection in selections
            call s:edit_file(selection.path, selection.lineno)
        endfor
    endif
endfunction

function! s:edit_file(path, lineno) abort
    let [path, lineno] = [a:path, a:lineno]
    exec 'edit +'.str2nr(lineno).' '.fnameescape(path)
    normal! zz
endfunction

function! s:new_file(path) abort
    exec 'edit '.fnameescape(a:path)
endfunction

" Read from given line up to the first blank line.
" TODO read files efficiently
function! s:read_file(path, lineno)
    let [path, lineno] = [a:path, a:lineno]
    let lines = []
    for line in readfile(path)[lineno:]
        call add(lines, line)
        if match(line, '^\s*$') >= 0
            return lines
        endif
    endfor
    return lines
endfunction
