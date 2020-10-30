if executable('pylint')
    CompilerSet errorformat=%f:%l:%c:%m
    " For configs, check out pylintrc at:
    " http://pylint.pycqa.org/en/latest/user_guide/run.html#command-line-options
    CompilerSet makeprg=pylint\ %:S
elseif executable('pylama')
    CompilerSet errorformat=%f:%l:%c:%m
    if empty($PYLAMA_OPTIONS)
        CompilerSet makeprg=pylama\ %:S
    else
        CompilerSet makeprg=pylama\ --options\ $PYLAMA_OPTIONS\ %:S
    endif
else
    throw 'No linter executables found.'
endif
