" Run as python module if there is __init__ file,
" else run as python script
if filereadable(expand(expand('%:h').'/__init__.py'))
    CompilerSet makeprg=python\ -m\ %:r:gs?[\/]?.?:S
    CompilerSet errorformat&
else
    CompilerSet makeprg=python\ %:S
    CompilerSet errorformat&
endif
