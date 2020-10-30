" Check pylama first since it delegates to other linters
if executable('pylama')
    CompilerSet errorformat=%f:%l:%c:%m
    if empty($PYLAMA_OPTIONS)
        CompilerSet makeprg=pylama\ %:S
    else
        CompilerSet makeprg=pylama\ --options\ $PYLAMA_OPTIONS\ %:S
    endif
    finish
endif

" For pylintrc configs, check out:
" http://pylint.pycqa.org/en/latest/user_guide/run.html#command-line-options
if executable('pylint')
    CompilerSet errorformat=%f:%l:%c:%m
    CompilerSet makeprg=pylint\ %:S
    finish
endif

throw 'No python linter executables found.'
