" IDE features: rename symbol, go to definition, find all references, ...

func! s:Format()
    if !exists('b:my_format_command')
        throw 'b:my_format_command not defined'
    endif
    exec b:my_format_command
endfunc
command! Format call s:Format()

func! s:Lint()
    if !exists('b:my_lint_command')
        throw 'b:my_lint_command not defined'
    endif
    exec b:my_lint_command
endfunc
command! Lint call s:Lint()

func! s:Fix()
    if exists('b:my_fix_command')
        exec b:my_fix_command
        return
    endif
    if exists(':ALEFix')
        ALEFix
        return
    endif
    throw 'No fix commands available'
endfunc
command! Fix call s:Fix()

func! s:FindReferences()
    if !exists('b:my_find_references_command')
        throw 'b:my_find_references_command not defined'
    endif
    exec b:my_find_references_command
endfunc
command! Refs call s:FindReferences()

func! s:RenameSymbol()
    if !exists('b:my_rename_symbol_command')
        throw 'b:my_rename_symbol_command not defined'
    endif
    exec b:my_rename_symbol_command
endfunc
command! Rn call s:RenameSymbol()

func! s:GotoDefinition()
    if !exists('b:my_goto_definition_command')
        throw 'b:my_goto_definition_command not defined'
    endif
    exec b:my_goto_definition_command
endfunc
command! Def call s:GotoDefinition()

func! s:PeekDocumentation()
    if !exists('b:my_peek_documentation_command')
        throw 'b:my_peek_documentation_command not defined'
    endif
    exec b:my_peek_documentation_command
endfunc
command! Peek call s:PeekDocumentation()
