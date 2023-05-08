CompilerSet errorformat=%f:%l:%c:%m
if empty($PYLAMA_OPTIONS)
    CompilerSet makeprg=pylama\ %:S
else
    CompilerSet makeprg=pylama\ --options\ $PYLAMA_OPTIONS\ %:S
endif
