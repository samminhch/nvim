return {
	"nvimtools/none-ls.nvim",
	keys = {
		{
			"<leader>cf",
			function()
				vim.lsp.buf.format({ async = true })
			end,
			desc = "[C]ode [F]ormat",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local formatter = null_ls.builtins.formatting
		local linter = null_ls.builtins.diagnostics

		null_ls.setup({
			sources = {
				formatter.stylua,
				formatter.prettier.with({ extra_args = { "--tab-width 4" } }),
				formatter.black.with({ extra_args = { "--fast" } }),
				formatter.isort,
				linter.eslint,
			},
		})
	end,
}
