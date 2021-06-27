augroup fmt
  autocmd!
  autocmd BufWritePre * silent! undojoin | silent! Neoformat
augroup END
