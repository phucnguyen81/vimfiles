" Language server support
" Source: https://github.com/prabirshrestha/vim-lsp
" Related: plugin/vim-lsp.vim

if !exists('g:lsp_loaded')
    finish
endif

" Diagnostics with LSP does not work very well, use other plugins (ALE, Syntastic, ...)
let g:lsp_diagnostics_enabled = 0

" Install: pip install python-language-server[all]
" Source: https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Python
if executable('pyls')
    autocmd User lsp_setup call lsp#register_server({
                \ 'name': 'pyls',
                \ 'cmd': {server_info->['pyls']},
                \ 'whitelist': ['python'],
                \ })
endif
