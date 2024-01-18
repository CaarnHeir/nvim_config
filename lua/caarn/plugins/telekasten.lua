return {
	event = "VeryLazy",
	"renerocksai/telekasten.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("telekasten").setup({
			home = vim.fn.expand("C:/users/caarn/telekasten/"),
		})
	end,
}
