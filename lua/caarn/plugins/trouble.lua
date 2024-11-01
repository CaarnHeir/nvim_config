return {
	"folke/trouble.nvim",
  lazy = true,
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("trouble").setup({
			modes = {
				diagnostics_buffer = {
					mode = "diagnostics",
					filter = { buf = 0 },
				},
				{
					win = { position = "right" },
				},
			},
		})
	end,
}
