local setup, vimtest = pcall(require, "vim-test")
if not setup then
	return
end

vimtest.setup({
	runner = "gradeltest",
	strategy = "neovim",
})
