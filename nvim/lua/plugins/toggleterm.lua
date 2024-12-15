return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup{
			direction = 'float'
		}
	end,
	keys = {
      { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm" },
	}

}
