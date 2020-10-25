" Do syntax-hightlight for languages in fenced blocks.
Plug 'https://github.com/tpope/vim-markdown.git'

let g:markdown_syntax_conceal = 0

let g:markdown_fenced_languages = [
  \ 'java',
  \ 'javascript',
  \ 'typescript',
  \ 'html',
  \ 'python',
  \ 'bash=sh',
  \ 'ps1',
  \ ]
