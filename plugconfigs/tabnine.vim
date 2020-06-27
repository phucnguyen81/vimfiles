" Auto-completion using Machine Learning
if has('python3_compiled')
      \ && (has('python3_dynamic') || has('python3'))

    Plug 'https://github.com/codota/tabnine-vim.git'

    " Auto-trigger the completion (or manually with <C-Space>)
    let g:ycm_auto_trigger = 1

    " <Down> or <C-n> for selecting next candidate
    let g:ycm_key_list_select_completion = ['<Down>']

endif
