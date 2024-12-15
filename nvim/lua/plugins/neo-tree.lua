-- Example for neo-tree.nvim
return {
	{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
		keys = {
      { "<leader>/", "<cmd>Neotree toggle current reveal_force_cwd<cr>", desc = "NeoTree toggle" },
      { "<leader>|", "<cmd>Neotree reveal <cr>", desc = "NeoTree reveal" },
      { "<leader>b", "<cmd>Neotree toggle show buffers right<cr>", desc = "NeoTree show buffers" },
      { "<leader>s", "<cmd>Neotree float git_status<cr>", desc = "NeoTree show git status" },
    },
	}
}
