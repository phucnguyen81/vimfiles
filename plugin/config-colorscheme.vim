if g:my_colorscheme ==# 'catppuccin'
    colorscheme catppuccin-frappe
    set background=dark
elseif g:my_colorscheme ==# 'everforest'
    let g:everforest_disable_italic_comment = 1
    colorscheme everforest
    set background=dark
elseif g:my_colorscheme ==# 'gruvbox'
    " Italic texts look broken sometimes
    let g:gruvbox_italic = 0
    colorscheme gruvbox
    set background=dark
elseif g:my_colorscheme ==# 'seoul256'
    " Dark theme:
    " Range:   233 (darkest) ~ 239 (lightest)
    " Default: 237
    let g:seoul256_background = 235

    " Light theme:
    " Range:   252 (darkest) ~ 256 (lightest)
    " Default: 253
    let g:seoul256_light_background = 253

    colorscheme seoul256
elseif g:my_colorscheme ==# 'solarized'
    let g:solarized_italic = 0
    colorscheme solarized
elseif g:my_colorscheme ==# 'tokyonight'
    let g:tokyonight_style = 'storm'  " available: night, storm
    let g:tokyonight_disable_italic_comment = 1  " disable italic comments
    let g:tokyonight_enable_italic = 0  " disable italic keywords
    if has('termguicolors')
        set termguicolors
    endif
    colorscheme tokyonight
elseif exists('g:my_colorscheme')
    exec 'colorscheme '.g:my_colorscheme
endif
