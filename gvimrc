" Vim internal encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Set color scheme
set background=dark
" silent! colorscheme gruvbox
silent! colorscheme OceanicNext

" Show window title and icons
set title icon

" Don't need menus, scroll bars, tab line...
set guioptions=c

" Don't blink cursor for n-v-c modes
set guicursor+=n-v-c:blinkon0

" Fonts to try
set guifont=Ubuntu\ Mono\ 12
set guifont+=IBM_Plex_Mono:h11
set guifont+=Source_Code_Pro:h11
set guifont+=InputMono_ExLight:h11
set guifont+=Consolas:h11

" Select fonts
command SetFont set guifont=*

" Add system clipboard to the '*' register
set clipboard+=unnamed
" Add system clipboard to the '+' register
if has('unnamedplus')
    set clipboard+=unnamedplus
endif
