let g:tokyonight_style = 'storm'  " available: night, storm
let g:tokyonight_disable_italic_comment = 1  " disable italic comments
let g:tokyonight_enable_italic = 0  " disable italic keywords

if g:my_colorscheme ==# 'tokyonight' && has('termguicolors')
    set termguicolors
    colorscheme tokyonight
endif
