let g:neoformat_only_msg_on_error = 1
augroup fmt
    autocmd!
    autocmd BufWritePre *.lua,*.json,*.yml,*.yaml,*.hcl,*.tf silent! undojoin | Neoformat
augroup END
