" Don't run linter on text changes, leaving insert mode, openning a file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" Don't use LSP feature with ALE
let g:ale_disable_lsp = 1
