" IDE features: rename symbol, go to definition, find all references, ...

function! s:Format()
    if !exists('b:my_format_command')
        throw 'b:my_format_command not defined'
    endif
    exec b:my_format_command
endfunction
command Format call s:Format()

function! s:Lint()
    if !exists('b:my_lint_command')
        throw 'b:my_lint_command not defined'
    endif
    exec b:my_lint_command
endfunction
command Lint call s:Lint()

function! s:Fix()
    if exists('b:my_fix_command')
        exec b:my_fix_command
        return
    endif
    if exists(':ALEFix')
        ALEFix
        return
    endif
    throw 'No fix commands available'
endfunction
command Fix call s:Fix()

function! s:FindReferences()
    if !exists('b:my_find_references_command')
        throw 'b:my_find_references_command not defined'
    endif
    exec b:my_find_references_command
endfunction
command Refs call s:FindReferences()

function! s:RenameSymbol()
    if !exists('b:my_rename_symbol_command')
        throw 'b:my_rename_symbol_command not defined'
    endif
    exec b:my_rename_symbol_command
endfunction
command Rn call s:RenameSymbol()

function! s:GotoDefinition()
    if !exists('b:my_goto_definition_command')
        throw 'b:my_goto_definition_command not defined'
    endif
    exec b:my_goto_definition_command
endfunction
command Def call s:GotoDefinition()

function! s:PeekDocumentation()
    if !exists('b:my_peek_documentation_command')
        throw 'b:my_peek_documentation_command not defined'
    endif
    exec b:my_peek_documentation_command
endfunction
command Peek call s:PeekDocumentation()

