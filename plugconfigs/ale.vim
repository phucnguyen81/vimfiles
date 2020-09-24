" Async syntax checker and language server protocol client.
Plug 'https://github.com/w0rp/ale.git'

let g:ale_enabled = 1
" Automatic linting is too aggressive in many cases
" (e.g. with Gdiff in fugitive)
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_filetype_changed = 0

" Use the global python-language-server
let g:ale_python_pyls_use_global = 1

" NOTE: ale conflicts with fugitive when doing Gdiff.
" Need to disable ale in buffer used for &diff.
augroup my_ale_disable
    autocmd!
    autocmd BufEnter * if &diff | let b:ale_enabled = 0 | endif
augroup end

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

nnoremap <Leader>al :ALELint<CR>
