return {
	"catppuccin/nvim",
	name = "catppuccin",
	-- "navarasu/onedark.nvim",
	-- name = "onedark",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			integrations = {
				gitsigns = true,
				telescope = true,
				cmp = true,
				treesitter = true,
				indent_blankline = {
					enabled = true,
				},
				nvimtree = true,
				native_lsp = {
					enabled = true,
				},
				bufferline = true,
			},
		})
		vim.cmd([[colorscheme catppuccin]])
	end,
}
