require "format".setup {
	["*"] = {{cmd = {"sed -i 's/[ \t]*$//'"}}},
	vim = {{cmd = {"luafmt -w replace"}, start_pattern = "^lua << EOF$", end_pattern = "^EOF$"}},
	lua = {
		{
			cmd = {
				function(file)
					return string.format("luafmt --use-tabs -w replace %s", file)
				end
			}
		}
	},
	go = {{cmd = {"gofmt -w", "goimports -w"}, tempfile_postfix = ".tmp"}},
	javascript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}}
}

vim.cmd(
	[[
augroup Format
    autocmd!
    autocmd BufWritePost *.lua FormatWrite
    autocmd BufWritePost *.go FormatWrite
augroup END
	]]
)
