" Auto-completion using ML
if has('python3_compiled') && (has('python3_dynamic') || has('python3'))
    Plug 'https://github.com/codota/tabnine-vim.git'
endif

" Don't auto-trigger the completion.
" Use <C-Space> to manually trigger the completion.
let g:ycm_auto_trigger = 0
