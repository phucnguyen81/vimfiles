" Auto-completion using Machine Learning.
" Nice but can be slow and buggy with vim popup windows.
Plug 'https://github.com/codota/tabnine-vim.git'

" Auto-trigger the completion (or manually with <C-Space>)
let g:ycm_auto_trigger = 1

" <Down> or <C-n> for selecting next candidate
let g:ycm_key_list_select_completion = ['<Down>']

" filetypes for turning off completion (just need keys, values are ignored)
let s:disable_completion = {
    \ 'fugitive': 1,
    \ 'gitcommit': 1,
    \ 'floaterm': 1,
    \}
let g:ycm_filetype_specific_completion_to_disable = s:disable_completion
let g:ycm_filepath_blacklist = s:disable_completion
