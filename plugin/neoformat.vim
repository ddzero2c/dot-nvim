let g:neoformat_only_msg_on_error = 1
augroup fmt
    autocmd!
    autocmd BufWritePre *.md,*.lua,*.yml,*.yaml,*.hcl silent! undojoin | Neoformat
augroup END
