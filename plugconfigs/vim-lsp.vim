" Language server support
Plug 'https://github.com/prabirshrestha/vim-lsp.git'

" Diagnostics with LSP does not work very well, use other plugins (ALE, Syntastic, ...)
let g:lsp_diagnostics_enabled = 0

" Install: pip install python-language-server[all]
" Source: https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Python
if executable('pyls')
    augroup my_vim_lsp
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pyls']},
          \ 'whitelist': ['python'],
          \ })
    augroup end
endif
