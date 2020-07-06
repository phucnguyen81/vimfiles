Plug 'https://github.com/gisphm/vim-polyglot.git'
Plug 'https://github.com/kevinoid/vim-jsonc.git'
Plug 'https://github.com/PProvost/vim-ps1.git'
Plug 'https://github.com/leafgarland/typescript-vim.git'
Plug 'https://github.com/tweekmonster/django-plus.vim.git'

" Options for html indent.
" See: $VIMRUNTIME/indent/html.vim
" Don't increase indent after first <script>
let g:html_indent_script1 = "zero"
" Don't indent after first <style>
let g:html_indent_style1 = "zero"
" Increase indent after these tags
let g:html_indent_inctags = "html,body,head,tbody"
" Don't increase indent after these tags
let g:html_indent_autotags = "p"

" vim-markdown
let g:vim_markdown_folding_disabled = 1
