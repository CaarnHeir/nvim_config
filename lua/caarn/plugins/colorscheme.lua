return {
	--	"catppuccin/nvim",
	--name = "catppuccin",
	"navarasu/onedark.nvim",
	name = "onedark",
	priority = 1000,
	-- make sure to load this before all the other start plugins
	--config = function()
	--require("catppuccin").setup({
	--flavour = "mocha",
	--intergrations = {
	--cmp = true,
	--gitsigns = true,
	--nvimtree = true,
	--},
	--})
	config = function()
		require("onedark").setup({
			style = "darker",
			lualine = {
				transparent = true,
			},
		})
		vim.cmd([[colorscheme onedark]])
	end,
}
