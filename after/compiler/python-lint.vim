" Check pylama first since it can delegate to other linters
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
CompilerSet errorformat=%f:%l:%c:%m,%f:%l:%m
CompilerSet makeprg=pylint\ --output-format=parseable\ %:S
