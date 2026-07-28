return {
	"HazielMagallanes/opencode.nvim",
	cmd = { "OpenCode", "OpenCodeWeb", "OpenCodeSessions" },
	keys = {
		{ "<leader>go", "<cmd>OpenCode<cr>", desc = "OpenCode TUI" },
		{ "<leader>gs", "<cmd>OpenCodeSessions<cr>", desc = "OpenCode Sessions" },
	},
	config = function(_, opts)
		require("opencode").setup(opts)
	end,
	opts = {
		sessions = { max_count = 30 },
	},
}
