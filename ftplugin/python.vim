setlocal expandtab autoindent smarttab
setlocal formatoptions=croql foldmethod=indent foldlevel=10
setlocal keywordprg=pydoc
setlocal suffixesadd+=.py
compiler python

" For lsp plugin
if exists('g:my_completion_plugin') && (g:my_completion_plugin == 'lsp')
    setlocal omnifunc=lsp#complete
    let b:my_rename_symbol_command = 'LspRename'
    let b:my_goto_definition_command = 'LspDefinition'
    let b:my_peek_documentation_command = 'LspHover'
    let b:my_find_references_command = 'LspReferences'
endif

" For jedi plugin
if exists('g:my_completion_plugin') && (g:my_completion_plugin == 'jedi')
    setlocal omnifunc=jedi#completions
    let b:my_rename_symbol_command = 'call jedi#rename()'
    let b:my_goto_definition_command = 'call jedi#goto()'
    let b:my_peek_documentation_command = 'call jedi#show_documentation()'
    let b:my_find_references_command = 'call jedi#usages()'
endif

" For ale plugin
if exists(':ALELint')
    let b:my_lint_command = 'ALELint'
endif
if exists(':ALEFix') && executable('autopep8')
    let b:my_fix_command = 'ALEFix autopep8'
endif

function! s:search_python_doc(symbol) abort
    call openbrowser#search('python '.a:symbol)
endfunction
let b:my_search_doc_function = funcref('s:search_python_doc')

if executable('ptpython')
    let b:my_shell = 'ptpython'
endif
