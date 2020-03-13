" Basic snippets support.
"
" Requires:
" fzf plugin
" g:my_snippets set to snippets directory
"
" Usage:
" <Leader>rs - read snippet
" <Leader>es - edit snippet
" <Leader>ns - new snippet

if !(exists('g:my_snippets') && isdirectory(g:my_snippets))
    finish
endif

if !isdirectory(g:my_snippets)
    call mkdir(g:my_snippets, 'p')
endif

" Read a snippet or create if not exists
nnoremap <Leader>rs :call <SID>ReadSnippet()<CR>

" Edit a snippet file
nnoremap <Leader>es :call <SID>EditSnippet()<CR>

" Create new snippet
nnoremap <Leader>ns :call <SID>NewSnippet()<CR>

function s:SnippetDir() abort
    return g:my_snippets
endfunction

" Read a file into current buffer
function s:ReadFile(filename) abort
    let fname = fnamemodify(a:filename, ':p')
    let lines = myfun#read_file(fname)
    if !empty(lines)
        exec "normal! jV".len(lines)."jo="
    endif
endfunction

" Fuzzy-search for a snippet; use current file type/extension as hint
function s:ReadSnippet() abort
    let snipdir = s:SnippetDir()

    let extension = expand('%:e')
    let filetype = &filetype
    let sniphint = (empty(extension) ? filetype : extension)

    call fzf#run({'dir': snipdir,
                \ 'sink': function('s:ReadFile'),
                \ 'down': '50%',
                \ 'options': ['--query='.sniphint.' ']
                \ })
endfunction

" Edit a snippet from snippet dir
function s:EditSnippet() abort
    let snipdir = s:SnippetDir()
    let snipname = ''
    if !empty(&filetype)
        let snipname = &filetype.' '
    endif
    call fzf#run({'dir': snipdir,
                \ 'sink': 'edit',
                \ 'options': ['--query='.snipname]
                \ })
endfunction

function s:NewSnippet() abort
    let snipdir = s:SnippetDir()
    if !empty(&filetype)
        let snipdir = join([snipdir, &filetype], '/')
    endif
    if !isdirectory(snipdir)
        call mkdir(snipdir, 'p')
    endif
    exec 'Sexplore '.fnameescape(snipdir)
endfunction

